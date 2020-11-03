# JSON Schema

[toc]

## 什么是 Schema

[What is a schema](https://json-schema.org/understanding-json-schema/about.html)

JSON 由这些数据结构构成:

```python
# object:

{ "key1": "value1", "key2": "value2" }

# array:

[ "first", "second", "third" ]

# number:

42
3.1415926

# string:

"This is a string"

# boolean:

true
false

# null:

null
```

Python 数据类型与 JSON Schema 之间的对应关系参考: [Pydantic documentation: json-schema-types](https://pydantic-docs.helpmanual.io/usage/schema/#json-schema-types)

具体的 JSON 数据与 Schema 之间的对应关系见下文.

## Python Validator

[jsonschema](https://github.com/Julian/jsonschema)

```bash
pip install jsonschema
```

## 在项目中共享 JSON Schema

### 架构

![json schema](https://latina-1253549750.cos.ap-shanghai.myqcloud.com/essay/imgs/20201103100021.png)

### 说明

在 `NACOS` 中增加 `JSON` 类型的配置项.

例如, 对于如下 python dict 数据:

```json
{
  "theme": "transaction_detail",
  "data": [
    {
      "stock_id": "000300.SH",
      "current_volume": 300,
      "buy_price": 333,
      "market_value": 123400,
      "time": "2020-01-01 12:32:12.232"
    },
    {
      "stock_id": "000302.SH",
      "current_volume": 300,
      "buy_price": 333,
      "market_value": 123400,
      "time": "2020-01-01 12:32:12.232"
    }
  ],
  "type": "account"
}
```

对应地, 在 NACOS 中增加如下的 JSON 项配置:

```json
{
  "type": "object",
  "properties": {
    "theme": { "type": "string" },
    "data": {
      "type": "object",
      "properties": {
        "stock_id": { "type": "string" },
        "current_volume": { "type": "integer" },
        "buy_price": { "type": "number" },
        "market_value": { "type": "number" },
        "time": { "type": "string" }
      }
    },
    "type": { "type": "string" }
  }
}
```

接着, 在项目中通过 NACOS api 获取该 schema 配置, 并使用 validator 对数据进行验证.

```python
from jsonschema import validate

simple_schema = {'type': 'object', 'properties': {'a': {'type': 'string'}}}
# pass
validate(instance={"a": 'foo'}, schema=simple_schema)
# raise ValidationError
validate(instance={"foo": 'bar'}, schema=simple_schema)
```
