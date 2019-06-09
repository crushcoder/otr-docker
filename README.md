# OTR - Online-TV-Recorder Tools
## Decode, Cut, Convert otrkey files to h264 für Playstation, iPhone, iPad, MacOS, Android

[Deutsche Version](README_de.md)

Image containing everything to work with otrkey files from http://onlinetvrecorder.com.
  My target is a automatic workflow.

Components:
	
* Easydekoder
* multicut_light (customized)
* ffmpeg
* avidemux 2.5.6
* Debian Wheezy Archived

### Usage

#### Batch - Decode, Cut, Convert to h264, Cleanup

	docker run -e "otrEmail=bla@fasel.de" -e "otrPassword=geheim" -e "cutlistAtUrl=http://cutlist.at/user/h52hm126h" -v ~/Downloads:/otr develcab/otr

* You need Docker: https://www.docker.com/products/docker-toolbox#/resources
  * __email__: E-Mail you use to login at onlinetvrecorder.com
  * __password__: Password you use to login at onlinetvrecorder.com
  * __cutlistAtUrl__: Your personal server-url / "Persönliche Server-URL" from http://cutlist.at (You need to register there)
  * The folder where your otrkey files are (here: _~/Downloads_)
    * All otrkey files in this folder will be processed by the auto.sh script
    * Also temporary files will be created, and deleted, in this folder
  * (optional) __renameFile=true__: Rename the file to used cutlist filename
  * (optional) __skipConvert=true__: Only decode and cut, but don't convert to m4v
  * (optional) __skipDecode=true__: No decode, only subsequent steps are executed
  * (optional) __skipCut=true__: Don't cut movie
  * (optional) __skipCleanup=true__: Don't delete intermediate files


#### Manuell

You can also use the image directly if you don't want the automatic process.
You only need to specify the folder with your otrkey files (here: _~/Downloads_)
	
	docker run -ti -v ~/Downloads:/otr develcab/otr bash
	
You can use _otrdecoder_, _multicut.sh_, _avidemux_ und _ffmpeg_.
There are also curl and wget.

I wrote some more scripts:

* ffall.sh - encodes all files in the current folder to h264 .m4v. Encoded files are stored in _converted_, while the source file will be moved to _original_
* mcall.sh - cuts all .avi files in current folder with multicut
	
__Important__: If you change a setting in the image, or install new software; these changes won't be saved.
After a restart of the image you start with a clean system.
If you want to change something you should build your own image, using this a base one or forking it.
	

### Customize

Fork it: https://github.com/crushcoder/otr-docker
Or just download and make your own image locally: https://github.com/crushcoder/otr-docker/archive/master.zip
	
* .multicut_light.rc - Preferences for the cutting script. E.g., if you want to be asked for the name of
	the cutted movie, you can override my settings for avidemux and you get the original behavior with adding the line
	
	  avidemuxOptions="--force-smart"
	  
* auto.sh
  * That's the script used in automatic mode
  * The first function contains the settings for ffmpeg
  * In the bottom you can find the blocks of execution
  * For example you can delete some lines after _# cleanup_ to keep intermediate files
* Dockerfile
  * The Dockerfile contains the installation of the whole otr system
  * Here you could change the cutting script or install further tools
  
  
### HowTo build the project

* Required: Docker Engine or Desktop https://www.docker.com/products/docker-engine

	docker build -t develcab/otr .
