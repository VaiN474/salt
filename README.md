# SALT
Save And Load Tables for Lua

### Description

Saves Lua table data to a file recursively and human-readable, with indentation. This is done by writing the data to the file on-the-fly while iterating through the table data.

Supported Types: `number`,`string`,`boolean`, sub-tables of the same. `function` and `userdata` types are not supported.

Because it's writing as it goes, any unsupported types will be saved as `nil` with a comment noting the error.

### Installation

##### LuaRocks

```bash
luarocks install salt
```

##### Git Clone

```bash
git clone https://github.com/VaiN474/salt.git
```

### Usage

```lua
salt = assert(require("salt"))

salt.save(my_table,"/path/to/file")
salt.save(my_table,"/path/to/file",true) -- data will be compressed

my_table,err = salt.load("/path/to/file")
```

When using `salt.load` it will return the table and nil, or if an error occurrs it will return nil and the error message.
