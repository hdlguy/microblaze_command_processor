library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

entity top is
port (
    sys_clock       :   in      STD_LOGIC;  -- 100MHz oscillator
    reset           :   in      STD_LOGIC;  -- active low reset button
    led_4bits       :   out     std_logic_vector( 3 downto 0);
    rgb_led         :   out     std_logic_vector(11 downto 0);
    usb_uart_rxd    :   in      STD_LOGIC;
    usb_uart_txd    :   out     STD_LOGIC

);
end top;

architecture STRUCTURE of top is

begin

    system_i: entity work.system
    port map (
        reset               => reset,
        sys_clock           => sys_clock,
        led_4bits_tri_o     => led_4bits,
        rgb_led_tri_o       => rgb_led,
        uart_rtl_rxd        => usb_uart_rxd,
        uart_rtl_txd        => usb_uart_txd
    );

end STRUCTURE;
