----------------
--Jakub Zaroda--
----------------

--modul serpent_dec laczy ze soba prace modulow skladowych
--przekazuje sygnaly wejsciowe do odpowiednich modulow oraz wypisuje odpowiednie wartosci na magistrale wyjsciowe
--korzysta z modulu serpent_control_dec ktory odpowiada za sterowanie koprocesorem
--korzysta z modulu serpent_keys_dec ktory odpowiada za wyznaczanie kolejnych kluczy rundowych
--korzysta z modulu serpent_keys_reg ktory przechowuje klucz glowny
--korzysta z modulu serpent_round_reg_dec ktory przechowuje stan algorytmu
--korzysta z modulu serpent_round_dec ktory wyznacza wyjscie kolejnych rund
--korzysta z modulu serpent_first_round ktory wyznacza wyjscie pierwszej rundy
--korzysta z modulu serpent_data_out_reg ktory przechowuje ostatni stan algorytmu


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity serpent_dec is port(
    in_clk       : in std_logic;                                --wejscie sygnalu zegarowego
    in_reset     : in std_logic;                                --wejscie sygnalu resetu
    in_key_wr    : in std_logic;                                --wejscie sygnalu zapisu klucza
    in_data_wr   : in std_logic;                                --wejscie sygnalu zapisu bloku danych
    in_data      : in std_logic_vector (127 downto 0);          --magistrala wejsciowa danych 128-bitowa
    in_key      : in std_logic_vector (255 downto 0);           --magistrala wejsciowa klucza 256-bitowa
    out_data     : out std_logic_vector (127 downto 0);         --magistrala wyjsciowa danych 128-bitowa
    out_busy     : out std_logic                                --wyjscie sygnalu pracy ukladu
);
end serpent_dec;

architecture behaviour of serpent_dec is
    signal wire_out_int_kesch_reg_ext_wr : std_logic;           --wewnetrzny sygnal sterujacy zapisem do rejestru klucza wartoscia z zewnatrz
    signal wire_out_int_round_reg_ext_wr : std_logic;           --wewnetrzny sygnal sterujacy zapisem do rejestru rundowego wartoscia z zewnatrz
    signal wire_out_int_round_reg_int_wr : std_logic;           --wewnetrzny sygnal sterujacy zapisem do rejestru rundowego wartoscia z wewnatrz

    signal wire_out_round_number : std_logic_vector (7 downto 0) := x"00";                  --rejestr przchowujacy numer rundy
    signal wire_out_round_number_one_more : std_logic_vector (7 downto 0) := x"00";         --rejestr przchowujacy numer rundy powiekszony o 1

    signal wire_out_int_data_out_wr : std_logic;                --wewnetrzny sygnal sterujacy zapisem do rejestru wyjsciowego
    
    signal wire_serpent_key : std_logic_vector(127 downto 0);           --rejestr przechowujacy klucz rundowy
    signal wire_serpent_key_last : std_logic_vector(127 downto 0);      --rejestr przechowujacy drugi klucz rundowy 

    signal wire_master_key : std_logic_vector(255 downto 0);            --rejestr wyjsciowy z rejestru kluczy przechowujacy klucz glowny

    signal wire_round_out : std_logic_vector(127 downto 0);             --rejestr wyjsciowy z funkcji rundy
    signal wire_round_in : std_logic_vector(127 downto 0);              --rejestr wejsciowy do funkcji rundy

    signal wire_first_round_out : std_logic_vector(127 downto 0);       --rejestr wyjsciowy z pierwszej funkcji rundy

    signal in_data_changed : std_logic_vector (127 downto 0);           --rejestr przechowujacy dane wejsciowe po zmianie na slowa z bajtow
    signal out_data_changed : std_logic_vector (127 downto 0);          --rejestr przechowujacy dane wyjsciowe przed zmiana na bajty ze slow

begin

    in_data_changed <= in_data(103 downto 96) & in_data(111 downto 104) & in_data(119 downto 112) & in_data(127 downto 120) & in_data(71 downto 64) & in_data(79 downto 72) & in_data(87 downto 80) & in_data(95 downto 88) & in_data(39 downto 32) & in_data(47 downto 40) & in_data(55 downto 48) & in_data(63 downto 56) & in_data(7 downto 0) & in_data(15 downto 8) & in_data(23 downto 16) & in_data(31 downto 24);


    inst_serpent_control_dec: entity work.serpent_control_dec port map(in_clk, in_reset, in_key_wr, in_data_wr, wire_out_int_kesch_reg_ext_wr, wire_out_int_round_reg_ext_wr, wire_out_int_round_reg_int_wr, wire_out_int_data_out_wr, wire_out_round_number, wire_out_round_number_one_more, out_busy);

    inst_serpent_keys_dec: entity work.serpent_keys_dec port map(in_clk, wire_master_key, wire_out_round_number, wire_serpent_key, wire_serpent_key_last);

    inst_serpent_keys_reg: entity work.serpent_keys_reg port map(in_clk, wire_out_int_kesch_reg_ext_wr, in_key, wire_master_key);

    inst_serpent_round_reg_dec: entity work.serpent_round_reg_dec port map(in_clk, wire_out_int_round_reg_ext_wr, wire_out_int_round_reg_int_wr, in_data_changed, wire_round_out, wire_first_round_out,wire_out_round_number ,wire_round_in);

    inst_serpent_round_dec: entity work.serpent_round_fun_dec port map(wire_round_in, wire_serpent_key, wire_out_round_number, wire_round_out);

    inst_serpent_first_round: entity work.serpent_first_round_fun port map(wire_round_in, wire_serpent_key, wire_serpent_key_last, wire_first_round_out);

    inst_serpent_data_out_reg: entity work.serpent_data_out_reg port map(in_clk, wire_out_int_data_out_wr, wire_round_out, out_data_changed);

    out_data <= out_data_changed(103 downto 96) & out_data_changed(111 downto 104) & out_data_changed(119 downto 112) & out_data_changed(127 downto 120) & out_data_changed(71 downto 64) & out_data_changed(79 downto 72) & out_data_changed(87 downto 80) & out_data_changed(95 downto 88) & out_data_changed(39 downto 32) & out_data_changed(47 downto 40) & out_data_changed(55 downto 48) & out_data_changed(63 downto 56) & out_data_changed(7 downto 0) & out_data_changed(15 downto 8) & out_data_changed(23 downto 16) & out_data_changed(31 downto 24);


end behaviour;