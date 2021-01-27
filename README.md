# silverline_terraform

A very basic example of using Terraform with the Silverline API.  The configuration will prompt for credentials, login to obtain a token and then use the token to get a list of configured proxies.

As mentioned in the main.tf comments, API request output is written to file (security risk, which could be mitigated), but there is currenlty no other option with Terraform until either:
    - terraform external data source allows muli-level json query, or...
    - terraform http data source allows POST (currently only GET is allowed), or...
    - f5 develop a Silverline Terraform Provider

If you see the following error, it is likely due to incorrect credentials:

```Error: Unsupported attribute: This object does not have an attribute named "data".```