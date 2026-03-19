module Dataflow_1(a, b, gt, eq, sm);
    input [3:0] a, b;
    output gt, eq, sm;
    
    assign eq=&(a~^b); //a==b
    assign gt=(a[3]& ~b[3]) |  //a>b
    ((a[3]~^b[3]) & (a[2]& ~b[2])) | 
    ((a[3]~^b[3]) & (a[2]& ~b[2]) & (a[1]& ~b[1])) |
     ((a[3]~^b[3]) & (a[2]& ~b[2]) & (a[1]& ~b[1]) & (a[0]& ~b[0]));
    assign sm=~(gt|eq);
endmodule 