package util;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public class Practice {

	public static void main(String[] args)  {
		int birthday= 920315;
		String a=String.valueOf(birthday);
		if(a.charAt(0)>5) {
			
			String a1="19"+a;
			System.out.println(a1);
		}
		
		String str = "오정초등학교";
		str = str.substring(0, str.length()-3);
		System.out.println(str);

	}
}
