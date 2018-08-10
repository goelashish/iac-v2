# variable "env" {
#   description = "The prefix for the names of table according to current global config for config server, eg perf1 perf2 prod etc"
# }

variable "count" {
  default = "1"
}

variable "name" {
  description = "(Required) The name of the table, this needs to be unique within a region."
}

variable "read_capacity" {
  description = "(Required)The number of read units for this table."
}

variable "write_capacity" {
  description = "(Required)The number of write units for this table."
}

variable "hash_key" {
  description = "(Required)The attribute to use as the hash key (the attribute must also be defined as an attribute record)."
  default     = "id"
}

variable "range_key" {
  description = "(Required)The attribute to use as the range key (must also be defined as an attribute record)."
  default     = ""
}

variable "attribute" {
  description = <<DESCRIPTION
Define table attributes. Each attribute has two properties:
    * name - The name of the attribute
    * type - One of: S, N, or B for (S)tring, (N)umber or (B)inary data.
Only define attributes on the table object that are going to be used as:
    * Table hash key or range key
    * LSI or GSI hash key or range key
Example:
attribute = [
    {
        name = "GameTitle"
        type = "S"
    },
    {
        name = "TopScore"
        type = "N"
    }
]
DESCRIPTION

  default = [{
    name = "id"
    type = "S"
  }]
}

variable "stream" {
  description = "Indicates whether Streams are to be enabled (true) or disabled (false). by default it will be disabled making stream condition false"
  default     = "disabled"
}

variable "stream_view_type" {
  description = <<DESCRIPTION
When an item in the table is modified, StreamViewType determines what information is written to the table's stream.
Valid values are KEYS_ONLY, NEW_IMAGE, OLD_IMAGE, NEW_AND_OLD_IMAGES.
DESCRIPTION

  default = ""
}

variable "ttl" {
  description = <<DESCRIPTION
Defines ttl which has two properties, and can only be specified once:
    * enabled - whether ttl is enabled or disabled.
    * attribute_name - The name of the table attribute to store the TTL timestamp in.
Example:
ttl = [
    {
        attribute_name = "TimeToExist"
        enabled = false
    }
]
DESCRIPTION

  default = []
}

variable "local_secondary_index" {
  description = <<DESCRIPTION
Describe an LSI on the table. These can only be allocated at creation so you cannot change this definition after you have created the resource.
For both local_secondary_index and global_secondary_index, the following properties are supported:
    * name - (Required) The name of the LSI or GSI
    * hash_key - (Required for GSI) The name of the hash key in the index.
               - Must be defined as an attribute in the resource.
               - Only applies to global_secondary_index
    * range_key - (Required) The name of the range key; must be defined
    * projection_type - (Required) One of "ALL", "INCLUDE" or "KEYS_ONLY" where:
        * ALL projects every attribute into the index
        * KEYS_ONLY projects just the hash and range key into the index
        * INCLUDE projects only the keys specified in the non_key_attributes parameter.
    * non_key_attributes - (Optional) Only required with INCLUDE as a projection type;
                         - A list of attributes to project into the index.
                         - These do not need to be defined as attributes on the table.
For global_secondary_index objects only, you need to specify write_capacity and read_capacity
in the same way you would for the table as they have separate I/O capacity.
Example:
local_secondary_index = [
    {
        name               = "LocalIndex"
        range_key          = "SomeRange"
        write_capacity     = 10
        read_capacity      = 10
        projection_type    = "ALL"
    }
]
DESCRIPTION

  default = []
}

variable "global_secondary_index" {
  description = <<DESCRIPTION
Describe a GSO for the table. This is subject to the normal limits on the number of GSIs, projected attributes, etc.
Example:
global_secondary_index = [
    {
        name               = "GameTitleIndex"
        hash_key           = "GameTitle"
        range_key          = "TopScore"
        write_capacity     = 10
        read_capacity      = 10
        projection_type    = "INCLUDE"
        non_key_attributes = ["UserId"]
    }
]
DESCRIPTION

  default = []
}

variable "tags" {
  type        = "map"
  default     = {}
  description = "A mapping of tags to assign to the resource."
}

variable "read_max_capacity" {
  description = "(Required)Maximum read capacity value for autoscaling"
}

variable "write_max_capacity" {
  description = "(Required)Maximum write capacity value for autoscaling"
}

variable "read_min_capacity" {
  description = "(Required)Minimum read capacity value for autoscaling"
}

variable "write_min_capacity" {
  description = "(Required)Minimum write capacity value for autoscaling"
}

variable "read_autoscaling" {
  default = "disabled"
}

variable "write_autoscaling" {
  default = "disabled"
}

variable "write_target_value" {
  description = "(Required)target value is used for metric utilization in specific "
}

variable "read_target_value" {
  description = "(Required)target value is used for metric utilization in specific "
}