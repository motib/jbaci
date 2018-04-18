if "%1"=="" goto nofile
java -jar jbaci.jar %1.cm
goto exit
:nofile
java -jar jbaci.jar
:exit
