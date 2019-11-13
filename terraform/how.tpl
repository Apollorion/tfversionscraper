All requests are <b>GET</b>.
<br><br>
Get this help page (<a href="%{ if docs_base_url == "NOT_SET" }http://${bucket_name}.s3-website.${region}.amazonaws.com/%{ else }${docs_base_url}%{ endif }">link</a>):<br>
<code>%{ if docs_base_url == "NOT_SET" }http://${bucket_name}.s3-website.${region}.amazonaws.com/%{ else }${docs_base_url}%{ endif }</code>
<br><br>
Get all terraform versions (<a href="%{ if docs_base_url == "NOT_SET" }http://${bucket_name}.s3-website.${region}.amazonaws.com/%{ else }${docs_base_url}%{ endif }all">link</a>):<br>
<code>%{ if docs_base_url == "NOT_SET" }http://${bucket_name}.s3-website.${region}.amazonaws.com/%{ else }${docs_base_url}%{ endif }all</code>
<br><br>
Get only the latest terraform version (<a href="%{ if docs_base_url == "NOT_SET" }http://${bucket_name}.s3-website.${region}.amazonaws.com/%{ else }${docs_base_url}%{ endif }latest">link</a>):<br>
<code>%{ if docs_base_url == "NOT_SET" }http://${bucket_name}.s3-website.${region}.amazonaws.com/%{ else }${docs_base_url}%{ endif }latest</code>
<br><br>
Get a specific terraform version (<a href="%{ if docs_base_url == "NOT_SET" }http://${bucket_name}.s3-website.${region}.amazonaws.com/%{ else }${docs_base_url}%{ endif }0.12.3">link</a>):<br>
<code>%{ if docs_base_url == "NOT_SET" }http://${bucket_name}.s3-website.${region}.amazonaws.com/%{ else }${docs_base_url}%{ endif }&lt;VERSION></code><br>
<ul><li><code>example: %{ if docs_base_url == "NOT_SET" }http://${bucket_name}.s3-website.${region}.amazonaws.com/%{ else }${docs_base_url}%{ endif }0.12.3</code></li></ul>
<br><br><br>
Created by Joey Stout, check me out at <a href="https://apollorion.com/">apollorion.com</a>. 2019