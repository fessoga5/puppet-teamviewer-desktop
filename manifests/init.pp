# vim: sts=4 ts=4 sw=4 expandtab autoindent
#
#INSTALL SKYPE ON DESKTOP
#
class puppet-teamviewer-desktop ($source, $destination = "/root/teamviewer.deb") {
    if defined (Exec["i386"]){
        exec{ "i386":
            command => "dpkg --add-architecture i386;apt-get update;",
            path => '/usr/bin:/bin:/usr/sbin:/sbin',
            unless => '/usr/bin/dpkg --print-foreign-architectures | /bin/grep i386'
        }
    }

    wget::fetch { 'teamviewer.deb':
        source      => $source,
        destination => $destination,
        timeout     => 0,
        verbose     => false,
    }

    package {"teamviewer":
        provider => dpkg,
        ensure   => latest,
        source   => $destination,
        require  => Wget::Fetch['teamviewer.deb']
    }
}
