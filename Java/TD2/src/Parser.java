import java.util.regex.Pattern;

public class Parser {
    public static void main(String[] args) {
        var regex = Pattern.compile("[^0-9]*[0-9]+");
        for (String arg : args) {
            if (regex.matcher(arg).matches()) {
                System.out.println(arg.replaceAll("[^0-9]", ""));
            }
        }

        System.out.println();

        var ipv4 = stringToIPV4("192.168.0.1");
        for (short e : ipv4) {
            System.out.println(e);
        }
    }

    /**
     * Converts a String to an IPV4 short array
     *
     * @param address String of the form xxx.xxx.xxx.xxx
     * @return a short array containing the IPV4 or {0, 0, 0, 0} if the address is not valid
     */
    public static short[] stringToIPV4(String address) {
        var regex = Pattern.compile("([0-9]{1,3})\\.([0-9]{1,3})\\.([0-9]{1,3})\\.([0-9]{1,3})");
        var matcher = regex.matcher(address);
        var ipv4 = new short[4];
        while (matcher.find()) {
            for (var i = 0; i < 4; i++) {
                ipv4[i] = Short.parseShort(matcher.group(i+1));
            }
        }
        return ipv4;

    }
}
