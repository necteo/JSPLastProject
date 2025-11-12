package com.sist.temp;

import java.util.Arrays;

public class ReserveMain {
	
	public static void main(String[] args) {
//		int r = (int) (Math.random() * 7) + 5;
//		String s = rand(r);
//		System.out.println(s);
		ReserveDAO dao = ReserveDAO.newInstance();
		for (int i = 1; i <= 31; i++) {
			int r = (int) (Math.random() * 7) + 5;
			String s = rand(r);
			dao.insert(i, s);
		}
	}
	
	public static String rand(int count) {
		String result = "";
		int[] com = new int[count];
		int su = 0;
		boolean bCheck = false;
		for (int i = 0; i < com.length; i++) {
			bCheck = true;
			while (bCheck) {
				su = (int) (Math.random() * 15) + 1;
				bCheck = false;
				for (int j = 0; j < i; j++) {
					if (com[j] == su) {
						bCheck = true;
						break;
					}
				}
			}
			com[i] = su;
		}
		Arrays.sort(com);
		System.out.println(Arrays.toString(com));
		for (int i : com) {
			result += i + ",";
		}
		result = result.substring(0, result.lastIndexOf(","));
		return result;
	}

}
