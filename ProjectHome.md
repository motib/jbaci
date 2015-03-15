# jBACI #
jBACI is an integrated development environment for learning concurrent programming by simulating concurrency. It was built from the compilers from BACI (Ben-Ari Concurrency Interpreter), developed by Bill Bynum and Tracy Camp, and from the interpreter BACI Debugger, developed by David Strite.

The BACI compilers translate concurrent programs in (subsets of) Pascal and C into an intermediate language called PCode. They support synchronization primitives like semaphores and monitors. BACI is written in C, so separate versions need to be built for each platform. The BACI Debugger is an interpreter for PCode written in Java so that it is portable. The debugger allows breakpoints and single-stepping by source statement or PCode instruction, and the GUI includes a comprehensive display of source code, PCode, variables, stack and history of executed PCode instructions. The major modifications of jBACI include (screen shot):

  * Graphics primitives have been added to the language. They are implemented by the corresponding Swing components.
  * Linda tuple space and synchronization primitives are implemented.
  * jBACI is an integrated development environment including an editor, invocation of the compilers and the interpreter.
> > o The cursor in the editor is placed at the location of the first compilation error.
> > o There is full support for the using keyboard with mnemonics and accelerators.
> > o The process table has been expanded to show the status of each process.
> > o The choice of compiler is automatic based upon the source file extension; the PCode file is automatically passed to the interpreter.
  * Configurability.
> > o Strings, keys and fonts are in a compile-time configuration file to facilitate localization of the GUI.
> > o The sizes and locations of GUI components, the locations of compilers and examples, and the default values of the options are taken from a configuration file that is read at run-time initialization.
  * The history of executed instructions can be by source statement as well as by PCode instruction. The history entries can also be written to a log file for off-line analysis.
  * The read instruction in processes (other than the main process) is non-blocking for game-like programming.

## Some images from the Graphical IDE of v1.4.6 ##
http://jbaci.googlecode.com/files/jbaci_ide.JPG
![http://jbaci.googlecode.com/files/jbacig0.jpg](http://jbaci.googlecode.com/files/jbacig0.jpg)
![http://jbaci.googlecode.com/files/jbacig1.jpg](http://jbaci.googlecode.com/files/jbacig1.jpg)
![http://jbaci.googlecode.com/files/jbacig2.jpg](http://jbaci.googlecode.com/files/jbacig2.jpg)



