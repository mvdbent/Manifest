# Manifest
<img src="https://raw.githubusercontent.com/mvdbent/Manifest/main/icon.png" width="300">

_**Current state of the scripts are:** "This project is 'As is" please be free to give me any feedback_

![GitHub](https://img.shields.io/github/license/mvdbent/Manifest)

## DESCRIPTION
If your environment uses an HTTPS server that is not a Jamf Pro HTTPS-capable distribution point to host your packages, you must create a custom manifest file and upload it along with the Signed Distribution Package to Jamf Pro.

## INFO
In this repo you can find the example script and a example pkg.

## USAGE
To run the script we need to provide a Signed Distribution Package and an URL where this package can be downloaded.

We need to type in the following command in the terminal:
```bash
./CreatePKGManifest.sh /path/to/*.pkg https://*URL"
```

For this example we are using the Signed Distribution Package in the GitHub repo /example-pkg/Branding-1.0-Distribution.pkg and we got the download URL by Right+Click or Ctrl+Click on the “raw” button of the Signed Distribution Package to  “Copy Link” https://github.com/mvdbent/Manifest/raw/main/Example-pkg/Branding-1.0-Distribution.pkg

```bash
./CreatePKGManifest.sh /example-pkg/Branding-1.0-Distribution.pkg https://github.com/mvdbent/Manifest/raw/main/Example-pkg/Branding-1.0-Distribution.pkg
```

see blog post 
