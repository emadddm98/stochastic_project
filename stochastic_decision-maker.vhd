library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;
use IEEE.math_real.all;

entity SDM is
    generic(cbit : integer := 64;
        fbit : integer := 8);
    port (
        confidence : in std_logic_vector(cbit-1 downto 0);
        bias_unbias : out std_logic_vector(fbit-1 downto 0);
        init_sng : in std_logic;
        write_address : in std_logic_vector(log2(fbit)-1 downto 0);
        write_val : in std_logic_vector(fbit-1 downto 0);
        system_output : out std_logic_vector(cbit-1 downto 0);
        rst : in std_logic;
        clk : in std_logic;
        write_enable : in std_logic
    );
end SDM;

architecture pre of SDM is

    -- Register File. Read always, write only when needed
    component RF is

        Generic (N_address: integer:= log2(fbit);
                 N_tot:     integer:= fbit);
    
        Port (
                Read_register:	    in	std_logic_vector(N_address-1 downto 0);
                Write_register:     in  std_logic_vector(N_address-1 downto 0);
                Write_data:         in  std_logic_vector(N_tot-1 downto 0);
                Reset:	            in	std_logic;
                Clk:	            in	std_logic;
                Enable_Write:       in 	std_logic;
                Read_data:        out std_logic_vector(N_tot-1 downto 0)
                );
    
    end component;

    component SNG is
        generic (nbit: integer := log2(fbit));
        port (
            init: in std_logic;
            outputN: out std_logic_vector(nbit-1 downto 0)
        );
    end component;

    signal read_addr: std_logic_vector(log2(fbit)-1 downto 0);
    signal read_val: std_logic_vector(fbit-1 downto 0);

begin
    sng_u: SNG
    port map (
        init_sng, read_addr
    );

    rf_u: RF
    port map (
        read_addr, write_address, write_val, rst, clk, write_enable, read_val
    );

    -- to be completed as I progress in my thesis journey...

    -- if you have some doubts or want to know more, contact me at mousavi.em98@gmail.com.

end pre;
