if "%1"=="" goto nofile
java -jar jbaci.jar %1.pm
goto exit
:nofile
java -jar jbaci.jar
:exit
