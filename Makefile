all:
	make -C NachoUIMonitor.iOS/NachoUIMonitorLib
	/Applications/Xamarin\ Studio.app/Contents/MacOS/mdtool build

clean:
	make -C NachoUIMonitor.iOS/NachoUIMonitorLib clean
	rm -fr NachoUIMonitor.iOS/bin
	rm -fr NachoUIMonitor.iOS/obj
