# HypeBot Studio

Take the thinking out of promoting your content.


## How to create a metered price for $0.07 per 1000 tokens.

```bash
stripe prices create \
  --unit-amount=7 \
  --currency=usd \
  --product=prod_MGkW3zo2Va23aq \
  -d "recurring[interval]"=month \
  -d "recurring[usage_type]=metered" \
  -d "transform_quantity[divide_by]=1000" \
  -d "transform_quantity[round]=up"
```
