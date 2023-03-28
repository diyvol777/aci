variable "leaf_interface_profile" {
  type = map(any)
  default = {
    leaf_interface_profile1 = {
      description = "Leaf_2201_2202_IntProf"
      name        = "Leaf_2201_2202_IntProf"
      #annotation  = "tag_leaf"
      #name_alias  = "name_alias"
      leaf_profile = "Leaf_2201_2202_SwSel"
    },
  }
}

variable "leaf_selector" {
  type = map(any)
  default = {
    leaf_selector1 = {
      name                    = "Leaf_2201_2202_SwSel"
      switch_association_type = "range"
      annotation              = "orchestrator:terraform"
      description             = "from terraform"
      name_alias              = "tag_leaf_selector"
      leaf_selector = "Leaf_2201_2202_SwSel"
    },
  }
}

variable "leaf_profile" {
  type = map(any)
  default = {
    Leaf_2201_2202_SwSel = {
      name        = "Leaf_2201_2202_SwSel"
      description = "From Terraform"
      annotation  = ""
      name_alias  = ""
      leaf_profile = "Leaf_2201_2202_SwSel"
      leaf_interface_profile = "leaf_interface_profile1"
      leaf_selector = {
        name                    = "Leaf_2201_2202_SwSel"
        switch_association_type = "range"
        node_block = {
          name  = "blk1"
          from_ = "2201"
          to_   = "2202"
        }
      }
    }
  }
}

variable "aci_access_port_selector" {
  type = map(any)
  default = {
       ############################## Beginning of block configuration for Server CZ220607CL  #############################  

      access_port_selector1= {
        description               = "Storage VPC"
        name                      = "DL380G10-CZ220607CL_VPC_Storage_PortSel"
        access_port_selector_type = "range"
        annotation                = "tag_port_selector"
        name_alias                = "alias_port_selector"
leaf_interface_profile = "leaf_interface_profile1"
    },


      access_port_selector2 = {
        description               = "Data VPC"
        name                      = "DL380G10-CZ220607CL_VPC_Data_PortSel"
        access_port_selector_type = "range"
        annotation                = "tag_port_selector"
        name_alias                = "alias_port_selector"
leaf_interface_profile = "leaf_interface_profile1"
   
    },

      access_port_selector3 = {
        description               = "MGMT VPC"
        name                      = "DL380G10-CZ220607CL_VPC_MGMT_PortSel"
        access_port_selector_type = "range"
        annotation                = "tag_port_selector"
        name_alias                = "alias_port_selector"
leaf_interface_profile = "leaf_interface_profile1"
 
    },
    ############################## Ending of block configuration for Server CZ220607CL  ############################# 
  }
}

variable "access_port_block" {
  type = map(any)
  default = {
       ############################## Beginning of block configuration for Server CZ220607CL  #############################  

      access_port_block1 = {
        PB_description = "CZ220607CL VPC Storage"
        PB_name        = "PortBlock1"
        from_card      = "1"
        from_port      = "1"
        to_card        = "1"
        to_port        = "1"
        access_port_selector = "access_port_selector1"

    },

          access_port_block2 = {
        PB_description = "CZ220607CL VPC DATA"
        PB_name        = "PortBlock2"
        from_card      = "1"
        from_port      = "2"
        to_card        = "1"
        to_port        = "2"
        access_port_selector = "access_port_selector2"

    },

              access_port_block3 = {
        PB_description = "CZ220607CL VPC MGMT"
        PB_name        = "PortBlock2"
        from_card      = "1"
        from_port      = "3"
        to_card        = "1"
        to_port        = "3"
        access_port_selector = "access_port_selector3"

    },


    ############################## Ending of block configuration for Server CZ220607CL  ############################# 




  }
}




locals {
  vpcs = {
    openstack_vpc1 = {
      name = "openstack_vpc"
    }
    vpc2 = {
      name = "vpc2"
    }
  }
  static_vlan_start  = "vlan-500"
  static_vlan_end    = "vlan-599"
  dynamic_vlan_start = "vlan-350"
  dynamic_vlan_end   = "vlan-399"
  access_port        = "03"
  access_leaf        = "203"
  PC_port_1          = "5"
  PC_port_2          = "6"
  PC_leaf            = "206"
  vpc_port_1         = "03"
  vpc_port_2         = "03"
  vpc_leaf_1         = "207"
  vpc_leaf_2         = "208"
}

variable "physical_domain_id" {
  default = ""
}




m
