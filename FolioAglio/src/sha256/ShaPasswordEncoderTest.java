package sha256;
 
import java.security.MessageDigest;
import java.util.Random;
public class ShaPasswordEncoderTest {
 
	public String getName(String pwd){
 
        try{
 
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(pwd.getBytes("UTF-8"));
            StringBuffer hexString = new StringBuffer();
 
            for (int i = 0; i < hash.length; i++) {
                String hex = Integer.toHexString(0xff & hash[i]);
                if(hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
 
            //출력
            System.out.println(hexString.toString());
            return hexString.toString();
 
        } catch(Exception ex){
            throw new RuntimeException(ex);
        }
 
    }
	 public static String generateSalt() {
	        Random random = new Random();
	         
	        byte[] salt = new byte[8];
	        random.nextBytes(salt);
	         
	        StringBuffer sb = new StringBuffer();
	        for (int i = 0; i < salt.length; i++) {
	            // byte 값을 Hex 값으로 바꾸기.
	            sb.append(String.format("%02x",salt[i]));
	        }
	         
	        return sb.toString();
	    }
 
}