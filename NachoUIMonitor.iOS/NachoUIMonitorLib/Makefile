LIB := libNachoUIMonitor.a
IPHONE_LIB := build/Release-iphoneos/$(LIB)
SIMULATOR_LIB := build/Release-iphonesimulator/$(LIB)
XCBUILD := xcodebuild -target NachoUIMonitor -configuration Release

.PHONY: $(IPHONE_LIB) $(SIMULATOR_LIB)

../$(LIB): $(IPHONE_LIB) $(SIMULATOR_LIB)
	lipo -create -output $@ $^

$(IPHONE_LIB):
	$(XCBUILD) -sdk iphoneos clean build

$(SIMULATOR_LIB):
	$(XCBUILD) -sdk iphonesimulator clean build


clean:
	rm -f $(LIB)
	rm -fr build/
