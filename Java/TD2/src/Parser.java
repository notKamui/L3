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
        for (byte e : ipv4) {
            System.out.println(e & 0xFF);
        }
    }

    /**
     * Converts a String to an IPV4 byte array
     *
     * @param address String of the form xxx.xxx.xxx.xxx
     * @return a byte array containing the IPV4 or {0, 0, 0, 0} if the address is not valid
     */
    public static byte[] stringToIPV4(String address) {
        var regex = Pattern.compile("([0-9]{1,3})\\.([0-9]{1,3})\\.([0-9]{1,3})\\.([0-9]{1,3})");
        var matcher = regex.matcher(address);
        var ipv4 = new byte[4];
        while (matcher.find()) {
            for (var i = 0; i < 4; i++) {
                var group = Short.parseShort(matcher.group(i+1));
                if (group > 255) return new byte[4];
                ipv4[i] = (byte)group;
            }
        }
        return ipv4;
    }
}
