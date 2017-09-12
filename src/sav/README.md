
Today, users integrating inFact to replace a randomize call must:
- Insert an include file into the testbench compilation.
- Manage instances of the inFact component class

This causes the following problems:
- Introduces a circular dependency (often) with TBI
- Makes the testbench dependent on inFact code
- Often complicates the user experience when component instances must be shared

- global per-type "unique per-site" control -- default to true
-> Should we distinguish sites that use a user-defined key (id) vs sites that use a location key (path:line)?
-> Could allow sharing across location-key sites, while being unique across user-defined key sites
- unique per specific key (false)

- global unique-per-thread control (default to true)
--> Share across threads

The uvm_rand_factory package attempts to address this issues by:
- Decoupling the request for randomization from the implementation
  - Allows the implementation to be mixed in during vopt
- Centralizing instance management, and allowing the user to
  - globally control whether 
