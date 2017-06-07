LIB := libNachoUIMonitor.a
IPHONE_LIB := build/Release-iphoneos/$(LIB)
SIMULATOR_LIB := build/Release-iphonesimulator/$(LIB)
XCBUILD := xcodebuild -target NachoUIMonitor -configuration Release

.PHONY: $(IPHONE_LIB) $(SIMULATOR_LIB)

../$(LIB): $(IPHONE_LIB) $(SIMULATOR_LIB)
	lipo -create -output $@ $^

$(IPHONE_LIB):
	$(XCBUILD) -sdk iphoneos build

$(SIMULATOR_LIB):
	$(XCBUILD) -sdk iphonesimulator build

clean:
	$(XCBUILD) -sdk iphoneos clean
	$(XCBUILD) -sdk iphonesimulator clean
	rm -f ../$(LIB)
