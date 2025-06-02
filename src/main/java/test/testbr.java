package test;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.ArrayList;

import model.booking_report;

public class testbr {
    public static void main(String[] args) {
        String csv_link = "https://docs.google.com/spreadsheets/d/e/2PACX-1vQaJfvyaWFrPsqSF72zHE0YKOszq-IN4VqhUia_DSAX4lI2xjLXlCO6UwzEP65WIH-yFNTeNbbKdAY0/pub?output=csv";

        ArrayList<booking_report> list = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new InputStreamReader(new URL(csv_link).openStream()))) {
            String line;
            int lineNumber = 0;

            while ((line = reader.readLine()) != null) {
                lineNumber++;
                try {
                    String[] row = line.split(",");

                    if (row.length < 2) {
                        throw new IllegalArgumentException("Thiếu cột dữ liệu");
                    }

                    int brId = Integer.parseInt(row[0].trim());
                    int brAmount = Integer.parseInt(row[1].trim());

                    booking_report br = new booking_report();
                    br.setBr_id(brId);
                    br.setBr_amount(brAmount);
                    list.add(br);
                } catch (Exception e) {
                    System.err.println("Lỗi ở dòng " + lineNumber + ": " + line);
                    System.err.println("Chi tiết: " + e.getMessage());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        for (booking_report br : list) {
            System.out.println("br_id: " + br.getBr_id() + ", br_amount: " + br.getBr_amount());
        }
    }
}
