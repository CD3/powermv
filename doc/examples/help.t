  $ powermv --help | tr -cd '\11\12\15\40-\176'
  Usage: powermv COMMAND [ARGS] [OPTIONS]
  
  Batch move files with the power of jinja2 templates.
  
  With great power comes great responsibility...
  
   Arguments 
   *  MATCH_PATTERN     Pattern to match input filenames against. [required]    
   *  REPLACE_TEMPLATE  Jinja2 template to render output filename with.         
                        [required]                                              
   *  FILES             [required]                                              
  
   Commands 
   --help -h  Display this message and exit.                                    
   --version  Display application version.                                      
  
   Parameters 
   EXECUTE --execute         -x  Execute move operations (by default, nothing   
     --no-execute                is moved, only a dry-run is performed).        
                                 [default: False]                               
   NAME-ONLY --name-only     -n  [default: False]                               
     --no-name-only                                                             
   OVERWRITE --overwrite         Proceed with executing operations even if they 
     --no-overwrite              would overwrite existing files. [default:      
                                 False]                                         
   VERBOSE --verbose         -v  Print extra status information. [default:      
     --no-verbose                False]                                         
   QUIET --quiet --no-quiet  -q  Don't print status information. [default:      
                                 False]                                         
  
