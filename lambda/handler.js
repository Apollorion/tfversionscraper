const axios = require("axios");
const cheerio = require("cheerio");
const AWS = require('aws-sdk');
const semver = require("semver");
const s3 = new AWS.S3();

const baseSiteUrl = "https://releases.hashicorp.com/terraform/";

const fetchData = async (item, url) => {
    const result = await axios.get(url);
    let $ = cheerio.load(result.data);
    let data = [];
    $(item).each(function(i, elm) {
        let element = $(elm).text().trim();
        if(element !== "../")
        data.push(element);
    });
    return data;

};

async function getChecksums(version, short_version) {
    let sum_url = baseSiteUrl+short_version+"/"+version+"_SHA256SUMS";
    let checksums = await axios.get(sum_url, {
        responseType: 'blob'
    });
    checksums = checksums.data.split("\n");

    let sumsArray = [];
    for(let checksum of checksums){
        let splitCheck = checksum.split("  ");
        let obj = {
            "version": splitCheck[1],
            "checksum": splitCheck[0]
        };
        if(obj.version !== undefined && obj.checksum !== undefined){
            sumsArray.push(obj);
        }
    }
    return sumsArray;
}

exports.handler = async function(event, context, callback) {
    let versions = await fetchData("li", baseSiteUrl);

    let data = {};
    let shortVersions = [];
    for(let version of versions) {
        let short_version = version.split("_")[1];
        shortVersions.push(short_version);

        // Get Checksums
        let checkSums = await getChecksums(version, short_version);
        let checksumSig = await axios.get(baseSiteUrl+short_version+"/"+version+"_SHA256SUMS.sig", {
            responseType: 'blob'
        });
        checksumSig = new Buffer.from(checksumSig.data, "binary").toString("base64");

        // Initial Object Creations for Version
        data[short_version] = {
            "version_name": version,
            "base64ChecksumSig": checksumSig,
            "architectures": {}
        };

        // Process Checksums
        for(let breakdown of checkSums){
            let architecture = breakdown.version.split(version+"_")[1].replace(".zip", "");
            data[short_version]["architectures"][architecture] = {
                "checksum": breakdown.checksum,
                "url": baseSiteUrl+short_version+"/"+breakdown.version
            };
        }
    }

    // Let everyone know what the latest version is
    data["latest"] = shortVersions.sort(semver.rcompare)[0];

    // Upload to s3
    await s3.putObject({
        Bucket: process.env.bucket_name,
        Key: 'allversions.json',
        ACL:'public-read',
        Body: JSON.stringify(data),
        ContentType: "application/json"
    }).promise();

};
