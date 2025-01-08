#!/usr/bin/env python3

import argparse


def maandelijkse_aflossing(bedrag, jaarlijkse_rente, termijn_jaar):
    return multiplier(jaarlijkse_rente, termijn_jaar) * bedrag


def multiplier(jaarlijkse_rente, termijn_jaar):
    r = jaarlijkse_rente / 12
    K = 12 * termijn_jaar
    a = 1 + r
    return a**K * (1 - a) / (1 - a**K)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(prog="interest", description="Compute the monthly downpayment.")
    parser.add_argument("amount", help="Amount in EUR", type=float)
    parser.add_argument("interest", type=float, help="Interest rate in percent")
    parser.add_argument("-d", type=int, default=20, help="Duration in years")

    args = parser.parse_args()

    print(f"Pay off {args.amount} EUR at interest {args.interest}%, {args.d} years | monthly payment: {maandelijkse_aflossing(args.amount, args.interest / 100., args.d)} EUR.")
