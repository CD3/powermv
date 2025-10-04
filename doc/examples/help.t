  $ powermv --help | tr -cd '\11\12\15\40-\176'
  Usage: powermv COMMAND [ARGS] [OPTIONS]
  
  Batch move files with the power of jinja2 templates.
  
  With great power comes great responsibility...
  
   Arguments 
   MATCH_PATTERN     Pattern to match input filenames against.                  
   REPLACE_TEMPLATE  Jinja2 template to render output filename with.            
   FILES             [default: []]                                              
  
   Commands 
   inc        Increment integer enumerations in filenames. This is a shorthand  
              for                                                               
   --help -h  Display this message and exit.                                    
   --version  Display application version.                                      
  
   Parameters 
   GLOBAL --global --all     -g -a  [default: False]                            
     --no-global --no-all                                                       
   EXECUTE --execute         -x     Execute move operations (by default,        
     --no-execute                   nothing is moved, only a dry-run is         
                                    performed). [default: False]                
   NAME-ONLY --name-only     -n     Apply match pattern to the file/dir name    
     --no-name-only                 only, not the entire path. [default: False] 
   OVERWRITE --overwrite            Proceed with executing operations even if   
     --no-overwrite                 they would overwrite existing files.        
                                    [default: False]                            
   VERBOSE --verbose         -v     Print extra status information. [default:   
     --no-verbose                   False]                                      
   QUIET --quiet --no-quiet  -q     Don't print status information. [default:   
                                    False]                                      
  
