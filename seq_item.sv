

import uvm_pkg::*;
`include "uvm_macros.svh"
class seq_item extends uvm_sequence_item; 

  
  rand bit psel;                         
  rand bit [7:0] paddr;
  rand bit pen;
  rand bit wr_en;
  rand bit [31:0] pwdata;
  bit [31:0] prdata;
  bit pready;
  bit pselverr;

  
  function new(string name="seq_item");
    super.new(name);
  endfunction
  
  `uvm_object_utils_begin(seq_item)
  
    `uvm_field_int(psel, UVM_ALL_ON)
    `uvm_field_int(paddr, UVM_ALL_ON)
    `uvm_field_int(pen, UVM_ALL_ON)
    `uvm_field_int(wr_en, UVM_ALL_ON)
    `uvm_field_int(pwdata, UVM_ALL_ON)
    `uvm_field_int(prdata, UVM_ALL_ON)
    `uvm_field_int(pready, UVM_ALL_ON)
  `uvm_field_int(pselverr, UVM_ALL_ON)
 
  `uvm_object_utils_end
  constraint A1 { paddr inside {11,22,33,44,55,66,77,88,99};
                 pwdata inside {[11:'hFF]};
                               }
  
  constraint wr_en_c { wr_en inside {0, 1};
                    
                     
                     }
  
endclass
    
    
