data "aci_access_switch_policy_group" "POD_01_SwPolGrp" {
  name  = "POD_01_SwPolGrp"
}

resource "aci_leaf_selector" "Leaf_2201_2202_SwSel" {
  for_each = var.leaf_selector
  leaf_profile_dn         = aci_leaf_profile.Leaf_2201_2202_SwSel[each.value.leaf_selector].id
  name                    = each.value.name
  switch_association_type = each.value.switch_association_type
  annotation              = each.value.annotation
  description             = each.value.description
  name_alias              = each.value.name_alias
  relation_infra_rs_acc_node_p_grp = data.aci_access_switch_policy_group.POD_01_SwPolGrp.id
}
resource "aci_leaf_profile" "Leaf_2201_2202_SwSel" {
  for_each = var.leaf_profile

  name         = each.value.name
  description  = each.value.description
  annotation   = each.value.annotation
  name_alias   = each.value.name_alias
  leaf_selector {
    name                    = each.value.leaf_selector.name
    switch_association_type = each.value.leaf_selector.switch_association_type
    node_block {
      name  = each.value.leaf_selector.node_block.name
      from_ = each.value.leaf_selector.node_block.from_
      to_   = each.value.leaf_selector.node_block.to_
    }
  }
  relation_infra_rs_acc_port_p = [aci_leaf_interface_profile.Leaf_2201_2202_IntProf[each.value.leaf_interface_profile].id]
}

resource "aci_leaf_interface_profile" "Leaf_2201_2202_IntProf" {
for_each = var.leaf_interface_profile
  description = each.value.description
  name        = each.value.name
  #annotation  = "tag_leaf"
  #name_alias  = "name_alias"
}

resource "aci_access_port_selector" "access_port_selector" {
  for_each                  = var.aci_access_port_selector
  leaf_interface_profile_dn = aci_leaf_interface_profile.Leaf_2201_2202_IntProf[each.value.leaf_interface_profile].id
  description               = each.value.description
  name                      = each.value.name
  access_port_selector_type = each.value.access_port_selector_type
  relation_infra_rs_acc_base_grp = aci_leaf_access_bundle_policy_group.intpolg_vpc1.id
}

resource "aci_access_port_block" "Access_Port_block" {
  for_each                = var.access_port_block
  access_port_selector_dn = aci_access_port_selector.access_port_selector[each.value.access_port_selector].id
  description             = each.value.PB_description
  name                    = each.value.PB_name
  from_card               = each.value.from_card
 from_port               = each.value.from_port
  to_card                 = each.value.to_card
  to_port                 = each.value.to_port
}




resource "aci_leaf_access_bundle_policy_group" "intpolg_vpc1" {
  name                          = "OpenStack_VPC"
  lag_t                         = "node"
  description                   = "aaep-openstack,cdp-enable,linklevel-auto,lldp-enable,lacp-active"
  relation_infra_rs_att_ent_p   = aci_attachable_access_entity_profile.openstack_aaep.id
  relation_infra_rs_cdp_if_pol  = data.aci_cdp_interface_policy.cdp_enable.id
  relation_infra_rs_h_if_pol    = data.aci_fabric_if_pol.Link_Level_AUTO.id
  relation_infra_rs_lldp_if_pol = data.aci_lldp_interface_policy.lldp_enable.id
  relation_infra_rs_lacp_pol    = data.aci_lacp_policy.lacp_active.id
  relation_infra_rs_mcp_if_pol  = data.aci_miscabling_protocol_interface_policy.mcp_enable.id
  #relation_infra_rs_l2_if_pol     = data.aci_l2_interface_policy.aci_lab_l2global.id
}

resource "aci_attachable_access_entity_profile" "openstack_aaep" {
  name                    = "openstack_aaep"
  relation_infra_rs_dom_p = [data.aci_physical_domain.physical_domain.id]
}


data "aci_physical_domain" "physical_domain" {
  name  = "BareMetal_PhysDom"
}

output "physical_domain_id" {
  value = "${data.aci_physical_domain.physical_domain.id}"
}

resource "aci_l3_domain_profile" "l3_domain_profile" {
  name = "aci_p03_extrtdom"
}

data "aci_vlan_pool" "openstack_static_vlanpool" {
  name  = "BareMetalServres_StaticVLPool"
  alloc_mode  = "static"
}

