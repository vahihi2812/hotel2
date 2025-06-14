package test;

import java.util.ArrayList;
import java.util.Random;

import dao.revenue_reportDAO;
import model.revenue_report;

public class testpay {

	public static void main(String[] args) {
		ArrayList<revenue_report> list = new ArrayList<>();
		Random rand = new Random();

		int year = 2025;
		int month = 6;

		for (int day = 1; day <= 14; day++) {
			int brId = year * 10000 + month * 100 + day;
			double amount = rand.nextDouble(50) + 10; // từ 10 đến 40

			// Sinh ngẫu nhiên 5 số sao cho tổng = amount
			double[] floors = splitAmountRandomly(amount, 5);

			revenue_report rr = new revenue_report(brId, amount, floors[0], floors[1], floors[2], floors[3], floors[4]);
			list.add(rr);
		}
		
		for(revenue_report rr : list) {
			revenue_reportDAO.getInstance().insertdaydu(rr);
		}

	}

	private static double[] splitAmountRandomly(double total, int parts) {
		Random rand = new Random();
		double[] result = new double[parts];
		double sum = 0;

		for (int i = 0; i < parts - 1; i++) {
			result[i] = rand.nextDouble(total - sum - (parts - i - 1) + 1); // tránh tràn
			sum += result[i];
		}
		result[parts - 1] = total - sum; // phần còn lại

		// Trộn ngẫu nhiên cho đều
		for (int i = parts - 1; i > 0; i--) {
			int j = rand.nextInt(i + 1);
			double tmp = result[i];
			result[i] = result[j];
			result[j] = tmp;
		}

		return result;
	}

}
