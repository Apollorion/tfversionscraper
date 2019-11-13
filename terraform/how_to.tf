data "template_file" "howto" {
  template = file("how.tpl")
  vars = {
    bucket_name   = aws_s3_bucket.main.id
    region        = var.aws_region
    docs_base_url = var.docs_base_url
  }
}

resource "aws_s3_bucket_object" "how" {
  bucket = aws_s3_bucket.main.id
  key    = "how"

  content = data.template_file.howto.rendered
  acl = "public-read"
  content_type = "text/html"

  etag = md5(data.template_file.howto.rendered)
}