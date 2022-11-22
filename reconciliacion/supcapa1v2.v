// esta capa hace referencia a la capa1 pero con 
// valores tipo one hot
//copia de la capa anterior

module capa1v2(
input reset,
input clk,
input [4:0]pls_data_request,
output reg gtx_clk,
output reg [7:0]txd,
output reg tx_en,
output reg tx_er);

//ocupamos para el reloj
reg [1:0]count;
reg [2:0]h;

//inicializamos el reloj
initial begin
count =1;
h=2;
end
//código para nuestra salida del gtx clk, con modificación de frecuencias
always @(posedge clk)begin
if (reset)begin
count =1;
gtx_clk = 0;
end
else if(count==(h/2))begin
count =1;
gtx_clk = ~gtx_clk;
end
end

//Código regido según la tabla de las salidas 
//correspondientes
always @(posedge gtx_clk)begin
if (reset)begin
tx_en = 0;
tx_er = 0;
txd = 0;
end//termina el if
//cero
else if ( pls_data_request == 5'b00001)begin
tx_en = 1;
tx_er = 0;
txd = 8'h4F;
end//termina else if
//uno
else if(pls_data_request == 5'b00010)begin
tx_en = 1;
tx_er = 0;
txd = 8'h3F;
end//termina else if
//extend error
else if(pls_data_request == 5'b00100)begin
tx_en = 0;
tx_er = 1;
txd = 8'h1F;
end//termina else if
//extend
else if(pls_data_request == 5'b01000)begin
tx_en = 0;
tx_er = 1;
txd = 8'h0F;
end//termina else if
//data complete
else if(pls_data_request == 5'b10000)begin
tx_en = 0;
tx_er = 0;
txd = 8'h5F;
end //termina el else if

end //termina el always

endmodule // termina el modulo
