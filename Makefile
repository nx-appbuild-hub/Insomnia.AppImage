# Copyright 2020 Alex Woroschilow (alex.woroschilow@gmail.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
PWD:=$(shell pwd)


all: clean

	mkdir --parents $(PWD)/build/Boilerplate.AppDir/insomnia
	apprepo --destination=$(PWD)/build appdir boilerplate libatk1.0-0 libatk-bridge2.0-0 libgtk-3-0

	echo '' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo 'LD_LIBRARY_PATH=$${LD_LIBRARY_PATH}:$${APPDIR}/insomnia' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo 'export LD_LIBRARY_PATH=$${LD_LIBRARY_PATH}' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo 'UUC_VALUE=`cat /proc/sys/kernel/unprivileged_userns_clone 2> /dev/null`' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo 'if [ -z "$${UUC_VALUE}" ]' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '    then' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '        exec $${APPDIR}/insomnia/insomnia --no-sandbox "$${@}"' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '    else' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '        exec $${APPDIR}/insomnia/insomnia "$${@}"' >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '    fi' >> $(PWD)/build/Boilerplate.AppDir/AppRun

	wget --output-document="$(PWD)/build/Insomnia.AppImage" "https://updates.insomnia.rest/downloads/linux/latest"
	chmod +x $(PWD)/build/Insomnia.AppImage
	cd $(PWD)/build && $(PWD)/build/Insomnia.AppImage --appimage-extract

	cp --force --recursive $(PWD)/build/squashfs-root/usr/lib/* $(PWD)/build/Boilerplate.AppDir/lib64
	cp --force --recursive $(PWD)/build/squashfs-root/usr/share/* $(PWD)/build/Boilerplate.AppDir/share
	rm -rf $(PWD)/build/squashfs-root/AppRun
	rm -rf $(PWD)/build/squashfs-root/usr	

	rm --force $(PWD)/build/Boilerplate.AppDir/*.desktop
	cp --force --recursive $(PWD)/build/squashfs-root/* $(PWD)/build/Boilerplate.AppDir/insomnia

	cp --force $(PWD)/build/squashfs-root/*.desktop $(PWD)/build/Boilerplate.AppDir/
	cp --force $(PWD)/build/Boilerplate.AppDir/share/icons/hicolor/128x128/apps/*.png $(PWD)/build/Boilerplate.AppDir/ || true
	cp --force $(PWD)/build/Boilerplate.AppDir/share/icons/hicolor/scalable/apps/*.svg $(PWD)/build/Boilerplate.AppDir/ || true

	export ARCH=x86_64 && $(PWD)/bin/appimagetool.AppImage $(PWD)/build/Boilerplate.AppDir $(PWD)/Insomnia.AppImage
	chmod +x $(PWD)/Insomnia.AppImage




	
	# wget --no-check-certificate --output-document=$(PWD)/build/build.rpm https://ftp.lysator.liu.se/pub/opensuse/distribution/leap/15.2/repo/oss/x86_64/libatk-1_0-0-2.34.1-lp152.1.7.x86_64.rpm
	# cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	# wget --no-check-certificate --output-document=$(PWD)/build/build.rpm https://ftp.lysator.liu.se/pub/opensuse/distribution/leap/15.2/repo/oss/x86_64/libatk-bridge-2_0-0-2.34.1-lp152.1.5.x86_64.rpm
	# cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	# wget --no-check-certificate --output-document=$(PWD)/build/build.rpm https://ftp.lysator.liu.se/pub/opensuse/distribution/leap/15.2/repo/oss/x86_64/libatspi0-2.34.0-lp152.2.4.x86_64.rpm
	# cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	# cp --force --recursive $(PWD)/build/usr/lib64/* $(PWD)/build/squashfs-root/usr/lib
	# cp --force --recursive $(PWD)/build/usr/share/* $(PWD)/build/squashfs-root/usr/share

	# export ARCH=x86_64 && $(PWD)/bin/appimagetool.AppImage $(PWD)/build/squashfs-root $(PWD)/Insomnia.AppImage
	# chmod +x $(PWD)/Insomnia.AppImage


clean:
	rm -rf $(PWD)/build


	




