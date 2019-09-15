from pizzapi import *

try:
    with open('pizza_info.txt', 'r') as f:
        lines = f.readlines()

    customer = Customer(*lines[0].split(','))
    address  = Address(*lines[1].split(','))
    store = address.closest_store()
except:
    print("Thank you for using gitgud pizza! Please enter your information below:")
    first_name = input("\tFirst Name: ")
    last_name = input("\tLast Name: ")
    email = input("\tEmail: ")
    phone = input("\tPhone: ")

    street = input("\tStreet Address: ")
    city = input("\tCity: ")
    state = input("\tState: ")
    zip_code = input("\tZip Code: ")

    customer = Customer(first_name, last_name, email, phone)
    address = Address(street, city, state, zip_code)
    store = address.closest_store()

    with open('pizza_info.txt', 'w+') as f:
        f.write(','.join([first_name, last_name, email, phone]) + '\n')
        f.write(','.join([street, city, state, zip_code]))

order = Order(store, customer, address)
order.add_item('P12IPAZA')
order.add_item('20BCOKE')

print("Ordering: ")
print("\t12-inch Pan Pizza")
print("\t20 oz Coca Cola\n")

print("Enter payment information (will not be saved):")
card_num = input("\tCard Number: ")
security_code = input("\tSecurity Code: ")
expr_date = input("\tExpiration Date (MMYY): ")
zip_code = input("\tZip Code: ")

confirmation = input("\nYOU ARE ABOUT TO ORDER PIZZA. DO YOU WANT PIZZA [Y/N]? ")
if confirmation.lower() == 'y':
    order.pay_with(PaymentObject(card_num, expr_date, security_code, zip_code))

