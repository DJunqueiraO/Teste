//
//  ModelSpacesV1.swift
//  Teste
//
//  Created by user208023 on 8/8/22.
//

import Foundation

struct SpaceType: Codable {
    var id: Int?
    var name: String?
}

struct SpaceClassification: Codable {
    var id: Int?
    var name: String?
}

struct SpaceCategory: Codable {
    var id: Int?
    var name: String?
}

struct SpaceFacility: Codable {
    var id: Int?
    var name: String?
}

struct SpaceNoise: Codable {
    var id: Int?
    var name: String?
}

struct SpaceContract: Codable {
    var id: Int?
    var name: String?
}

struct SpaceBusinessHours: Codable {
    var id: Int?
    var space_id: Int?
    var week_day: Int?
    var start_time: String?
    var end_time: String?
}

struct Door: Codable {
    var door_id: Int?
    var door_type: Int?
    var door_lock_serial: String?
    var door_lock_code: String?
    var door_lock_key: String?
    var door_lock_manufacture: [DoorLockManufacture]?
}

struct DoorLockManufacture: Codable {
    var id: Int?
    var name: String?
}

struct PartnerSiteAddress: Codable {
    var address_id: Int?
    var business_name: String?
    var address: PartnerAddress
}

struct PartnerAddress: Codable {
    var street: String?
    var street_number: Int?
    var neighborhood: String?
    var complement: String?
    var postal_code: Int?
    var state_id: Int?
    var state_name: String?
    var city_id: Int?
    var city_name: String?
    var latitude: String?
    var longitude: String?
}

struct SpaceContact: Codable {
    var id: Int?
    var name: String?
    var email: String?
    var phone_number: String?
}

struct SpacePicture: Codable {
    var id: Int?
    var space_id: Int?
    var picture_uuid: String?
    var name: String?
    var url: String?
    var is_cover_photo: Bool?
}

struct Space: Codable {
    var name: String?
    var slogan: String?
    var description: String?
    var size_mt2: Double?
    var seats_qty: Int?
    var allow_half_slot: Bool?
    var favorite_space: Bool?
    var hourly_price: Double?
    var daily_price: Double?
    var monthly_price: Double?
    var allow_workpass: Bool?
    var hourly_credits: Int?
    var daily_credits: Int?
    var monthly_credits: Int?
    var is_active: Bool?
    var has_qrcode: Bool?
    var partner_site_id: Int?
    var space_catgegory: SpaceCategory?
    var space_type: SpaceType?
    var space_classification: SpaceClassification?
    var space_noise_level: SpaceNoise?
    var space_facilitites: [SpaceFacility]?
    var space_bussiness_hours: [SpaceBusinessHours]?
    var space_types_contracts: [SpaceContract]?
    var doors: [Door]?
    var partner_site_address: PartnerSiteAddress?
    var contact: SpaceContact?
    var pictures: [SpacePicture]?
}