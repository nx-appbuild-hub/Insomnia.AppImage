SOURCE="https://updates.insomnia.rest/downloads/linux/latest"
DESTINATION="Insomnia.AppImage"

all:
	echo "Building: $(OUTPUT)"
	wget -O $(DESTINATION)  $(SOURCE)
	chmod +x $(DESTINATION)
