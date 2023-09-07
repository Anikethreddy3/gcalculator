
#Flutter Import-Export Trade Decision Calculator
#Overview
This calculator is designed to assist traders in the import/export industry in making informed trade decisions. By inputting key details related to their trade, users can get a clear picture of their total costs both in INR and USD. This can help traders decide whether a particular trade would be profitable or not.

Features
Cost Calculations: Calculates the total cost based on the following inputs:
Total quantity
Price per Kg
Transportation cost
Total CHA (Clearing House Agent charges)
Currency Conversion: Uses a current dollar rate fetched via API or allows manual input to provide:
Total cost in INR and USD
Price per ton in INR and USD
API Integration: Automatically fetches the current dollar rate to ensure up-to-date conversions.
How to Use
Start the App: Launch the app on your device.

Input Trade Details: Enter the total quantity, price per Kg, transportation cost, and total CHA in the respective fields.

Dollar Rate:

If you have internet access, the app will automatically fetch the current dollar rate using the integrated API.
Alternatively, you can manually input the current dollar rate if needed.
View Results: Once all the required information is inputted, the app will display:

Total cost in INR and USD
Price per ton in INR and USD
Make Informed Decisions: Evaluate the calculated costs to make an informed trade decision.

Requirements
Flutter SDK version XX.XX
An internet connection (for fetching the current dollar rate via API)
Installation
Clone/download the repository
Navigate to the project directory
Run flutter pub get
Build and run the app using flutter run
Feedback and Contributions
We welcome feedback, bug reports, and feature requests. If you're interested in contributing to the project, please open a new issue or submit a pull request.

License
This project is licensed under the XYZ License - see the LICENSE.md file for details.
