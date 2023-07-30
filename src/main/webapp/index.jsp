<%@ page import="java.util.Formatter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>BMI Calculator</title>
        <link href="static/css/style.css" rel="stylesheet"/>
    </head>
    <body>
        <%!
            boolean isNumber(String parameter) {
                return parameter != null && parameter.matches("\\d+");
            }

            double calculateBMI(double weight, double height) {
                double heightInMeters = height / 100.0;
                return weight / (heightInMeters * heightInMeters);
            }
        %>
        <div class="container">
            <form action="" method="post">
                <h1>BMI Calculator</h1>
                <div class="input-group">
                    <label for="weight">Weight (kg):</label>
                    <input type="number" id="weight" name="weight" placeholder="Enter your weight">
                </div>
                <div class="input-group">
                    <label for="height">Height (cm):</label>
                    <input type="number" id="height" name="height" placeholder="Enter your height">
                </div>
                <button type="submit">Calculate BMI</button>
                <div id="result">
                    <%
                        if ("POST".equalsIgnoreCase(request.getMethod())) {
                            String weightParam = request.getParameter("weight");
                            String heightParam = request.getParameter("height");

                            if (isNumber(weightParam) && isNumber(heightParam)) {
                                double weight = Double.parseDouble(weightParam);
                                double height = Double.parseDouble(heightParam);
                                double bmi = calculateBMI(weight, height);

                                String classification = "";
                                String color = "";

                                if (bmi < 16) {
                                    classification = "Severe Thinness";
                                    color = "#BC2020";
                                } else if (bmi >= 16 && bmi < 17) {
                                    classification = "Moderate Thinness";
                                    color = "#D38888";
                                } else if (bmi >= 17 && bmi < 18.5) {
                                    classification = "Mild Thinness";
                                    color = "#FFE400";
                                } else if (bmi >= 18.5 && bmi < 25) {
                                    classification = "Normal";
                                    color = "#008137";
                                } else if (bmi >= 25 && bmi < 30) {
                                    classification = "Overweight";
                                    color = "#FFE400";
                                } else if (bmi >= 30 && bmi < 35) {
                                    classification = "Obese Class I";
                                    color = "#D38888";
                                } else if (bmi >= 35 && bmi < 40) {
                                    classification = "Obese Class II";
                                    color = "red";
                                } else {
                                    classification = "Obese Class III";
                                    color = "#8A0101";
                                }
                    %>
                    <p>Your BMI:
                            <%
                                Formatter formatter = new Formatter();
                                formatter.format("%.2f", bmi);
                                out.write(formatter.toString());
                            %>
                    </p>

                    <p>
                        Classification: <%= classification %>
                    </p>

                    <script>
                        document.getElementById("result").style.color = "<%= color %>";
                    </script>
                    <%
                        } else {
                    %>
                    <p>Please enter valid weight and height.</p>
                    <%
                         }
                    }
                    %>
                </div>
            </form>
        </div>
    </body>
</html>
