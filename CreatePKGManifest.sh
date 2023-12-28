#!/bin/sh

####################################################################################################
#        License information
####################################################################################################
#
#        THE SCRIPTS ARE PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, 
#        INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY 
#        AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL 
#        I BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, 
#        OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
#        SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
#        INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
#        CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
#        ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF 
#        THE POSSIBILITY OF SUCH DAMAGE.
#
####################################################################################################
# 
# Version 1.0
# Written by: Mischa van der Bent
#
# DESCRIPTION
# This script creates a manifest file for JAMF Pre-stage Deployments packages 
# 
# INFO MANIFEST
# https://support.apple.com/en-eg/guide/deployment/dep873c25ac4/web
# https://learn.jamf.com/bundle/jamf-pro-documentation-10.40.0/page/Computer_PreStage_Enrollments.html
#
# USAGE
# ./CreatePKGManifest.sh /path/to/*.pkg https://*URL"
#
# REQUIREMENTS
# Signed Distribution package
# 
####################################################################################################
####################################################################################################

# Check for needed input, pkgPath and URL if one is missing exit 1
if [[ $1 = "" ]]; then
    echo "Missing package path"
    echo "Example: ./CreatePKGManifest.sh /path/to/*.pkg https://*URL"
    exit 1
elif [[ $2 = "" ]]; then
    echo "Missing URL"
    echo "Example: ./CreatePKGManifest.sh /path/to/*.pkg https://*URL"
    exit 1
else
    pkgPath=$1
    url=$2
fi

# Fingerprint (checksum) if the PKG 
md5=$(md5 $pkgPath | awk '{print $NF}')

# The size of the pkg in bytes
byteSize=$(stat -f%z $pkgPath)

# Create Manifest file
echo '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>items</key>
    <array>
      <dict>
        <key>assets</key>
        <array>
          <dict>
            <key>kind</key>
            <string>software-package</string>
            <key>md5-size</key>
            <integer>'$byteSize'</integer>
            <key>md5s</key>
            <array>
              <string>'$md5'</string>
            </array>
            <key>url</key>
            <string>'$url'</string>
          </dict>
        </array>
      </dict>
    </array>
  </dict>
</plist>' > /Users/Shared/manifest.plist

# Open location where Manifest is created.
open /Users/Shared