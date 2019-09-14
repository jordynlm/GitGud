from pizzapi import *

with open('pizza_info.txt', 'r') as f:
    lines = f.readlines()

customer = Customer(*lines[0].split(','))
address  = Address(*lines[1].split(','))

store = address.closest_store()
menu = store.get_menu()

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

order.pay_with(PaymentObject(card_num, expr_date, security_code, zip_code))

