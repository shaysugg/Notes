On MacOS, you can also use the built-in `swcutil` tool for validation and verification:
- Run `sudo swcutil dl -d <domain>` to check that the AASA JSON can be downloaded successfully.
- Run `sudo swcutil verify -d <domain> -j <path-to-JSON> [-u <URL>]` to check the contents of a downloaded `.json` AASA file. Verify that your domains match with `-d` and your URL path pattern matches with the JSON with `-u`. If both are successful, you will get a confirmation message.

Example usage:

```bash
# check that the file can be downloaded
sudo swcutil dl -d example.com

# download the file, the swcutil outputs the file in non-json format
curl https://example.com/.well-known/apple-app-site-association > example.json

# run the test
sudo swcutil verify -d example.com -j ./example.json -u https://example.com/test

# If the pattern matches, you'll see a message saying that pattern was successfully matched

> { s = applinks, a = ABCD123.com.example.app, d = example.com }: Pattern "https://example.com/test" matched.

# If pattern matching fails, you'll see the following error instead:
> Input JSON did not match input URL.
```

[https://developer.apple.com/documentation/technotes/tn3155-debugging-universal-links](https://developer.apple.com/documentation/technotes/tn3155-debugging-universal-links)