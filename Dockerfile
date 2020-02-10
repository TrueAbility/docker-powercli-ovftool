
FROM amd64/ubuntu:18.04
MAINTAINER TrueAbility, Inc. <ops@trueability.com>

LABEL version="0.1"
LABEL description="Docker Image for VMWare PowerCLI + OVFTool"

WORKDIR /root
ENV TERM linux

ADD /src/VMware-ovftool-4.3.0-7948156-lin.x86_64.bundle /root/ovftool.bundle

RUN apt-get update \
    && apt-get install -y \
        wget \
        software-properties-common \
    && wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && apt-get update \
    && add-apt-repository universe \
    && apt-get install -qy powershell \
    && echo "/usr/bin/pwsh" >> /etc/shells \
    && echo "/bin/pwsh" >> /etc/shells \
    && pwsh -c "Set-PSRepository -Name PSGallery -InstallationPolicy Trusted" \
    && pwsh -c "\$ProgressPreference = \"SilentlyContinue\"; Install-Module VMware.PowerCLI,PowerNSX" \
    && pwsh -c "Set-PowerCLIConfiguration -Scope AllUsers -DefaultVIServerMode Single -InvalidCertificateAction Ignore -ParticipateInCEIP \$false -Confirm:\$false" \
    && chmod +x ovftool.bundle \
    && /root/ovftool.bundle --eulas-agreed --required \
    && apt-get -qy autoremove \
    && rm -f /root/ovftool.bundle
CMD ["/usr/bin/pwsh"]
