import argparse
import json
import  random
import datetime

donatorsDict = {
    "Target" : "tyler@target.com",
    "Walmart" : "wyatt@walmart.com",
    "Save Mart" : "samson@savemart.com",
    "Krogers" : "kevin@krogers.com",
    "Trader Joe's" : "theTraderJoe@traderjoes.com",
    "Goodness Greens" : "george@goodnessgreens.com",
    "Tyson Foods" : "tyson@tysonfoods.com",
    "Panera Bread" : "heypanini@panerabread.com",
    "Kellogg" : "kyle@kellogg.com",
    "The Salvation Army" : "sally@salvationarmy.com",
    "East Mesa Baptist Church" : "marie@mesabaptist.com",
    "Trinity Christian Fellowship" : "troy@trinityfellowship.com",
    "Vineyard Community Church" : "vincent@vineyardchurch.com",
    "Bill Gates" : "bgates@microsoft.com",
    "Michael Crow" : "yaboicrow@asu.edu",
    "Scrooge McDuck" : "duck@disney.com"
}
descriptionsDict = ("Baking", "Dry", "Meat", "Dairy", "Deli")
donators = []
donations = []

parser = argparse.ArgumentParser()
parser.add_argument("--normalPath",
    help="Path to store JSON file of the normal test data")
parser.add_argument("--generateNum",
    help="Number of data entries generated for the normal test data",
    type=int)
parser.add_argument("--edgePath",
    help="Path to store JSON file of the edge cases test data")
args = parser.parse_args()

def main():
    if args.normalPath is not None:
        num = 5
        if args.generateNum is not None:
            num = args.generateNum
        while num > 0:
            generateDonation()
            num -= 1
        writeDonations(args.normalPath)

    if args.edgePath is not None:
        donations.clear()
        genEdgeDonations()
        writeDonations(args.edgePath)

def generateDonation():
    name = random.choice(list(donatorsDict.keys()))
    weight = random.random() * 100;
    date = datetime.datetime.now(datetime.timezone.utc)
    description = random.choice(descriptionsDict)
    email = ""
    if name not in donators:
        donators.append(name)
        email = donatorsDict.get(name)

    donation = {
        "name" : name,
        "weight" : weight,
        "date" : date,
        "description" : description,
        "email" : email
    }
    donations.append(donation)

def genEdgeDonations():
    donations.append({"thisIs" : "cool"})

def writeDonations(path):
    print(donations)

main()
