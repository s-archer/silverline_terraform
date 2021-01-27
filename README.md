# silverline_terraform

A very basic example of using Terraform with the Silverline API.  You can find Silverline API documentation here: https://portal.f5silverline.com/docs/api/v1/index.md.  Please note that access is limited to authenticated users only.

When applying the configuration, Terraform will prompt for your credentials, login to Silverline to obtain a token and then use the token to get a list of configured proxies within your account.

As mentioned in the main.tf comments, API request output is written to file (security risk, which could be mitigated), but there is currenlty no other option with Terraform until either:
- terraform external data source allows muli-level json query, or...
- terraform http data source allows POST (currently only GET is allowed), or...
- f5 develop a Silverline Terraform Provider

If you see the following error, it is likely due to incorrect credentials:

```Error: Unsupported attribute: This object does not have an attribute named "data".```

This configuration does not conform to the DRY principle.  A second revision of this configuration will correct that problem using a module to perform the API calls.  Each call of the module would provide METHOD, PATH and DATA. 