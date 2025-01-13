# MIT License
#
# Copyright (c) 2024 Gerald Venzl
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import requests
import os
import sqlite3 as sql

API_KEY = os.getenv("API_KEY")
BASE_URL = "https://developer.nps.gov/api/v1"
db = sql.connect("data.db")


def sanitize_park_code(park_code: str) -> str:
    if park_code in ("mall", "nacc", "joer", "gemm"):
        return "nama"
    elif park_code == "nwwm":
        return "wwii"
    elif park_code == "dela":
        return "dewa"
    elif park_code == "foca":
        return "timu"
    else:
        return park_code


def sanitize_phone_number(number: str) -> str:
    # Replace ( ) - / " " . from phone number
    return (number
            .replace("(", "")
            .replace(")", "")
            .replace("-", "")
            .replace("/", "")
            .replace(" ", "")
            .replace(".", "")
            )


def get_contact_type(contact_type: str) -> int:
    contact_type = contact_type.lower()
    if contact_type == "email":
        return 1
    elif contact_type == "voice":
        return 2
    elif contact_type == "fax":
        return 3
    elif contact_type == "tty":
        return 4


def convert_tags(tags: list) -> str:
    return "|".join(tags)


def get_park_pictures():
    # There is a limit of 1000 API calls an hour.
    # Looping through galleries + assets per gallery exceeds that limit.
    # resp = requests.get(BASE_URL + "/multimedia/galleries?limit=1&api_key={}".format(API_KEY))
    # if not resp.ok:
    #     print(resp.text)
    # else:
    #     max_galleries = int(resp.json()["total"])
    #     gallery_step = 10000
    #     for gallery_page in range(0, max_galleries, gallery_step):
    #         resp_gallery = requests.get(BASE_URL + "/multimedia/galleries?start={}&limit={}&api_key={}"
    #                                    .format(gallery_page, gallery_step, API_KEY))
    #         if not resp_gallery.ok:
    #            print("Cannot retrieve galleries in range start: {}, limit: {}".format(gallery_page, gallery_step))
    #            print(resp_gallery.text)
    #         else:
    #            for gallery in resp_gallery.json()["data"]:
    #                gallery_id = gallery["id"]
    resp = requests.get(BASE_URL + "/multimedia/galleries/assets?limit=1&api_key={}"
                        .format(API_KEY))
    if not resp.ok:
        print("Cannot get galleries assets")
        print(resp.text)
    else:
        max_assets = int(resp.json()["total"])
        asset_step = 10000
        for asset_page in range(0, max_assets, asset_step):
            resp_assets = requests.get(
                BASE_URL + "/multimedia/galleries/assets?start={}&limit={}&api_key={}"
                .format(asset_page, asset_step, API_KEY))
            if not resp_assets.ok:
                print("Cannot retrieve assets in range start: {}, limit: {}"
                      .format(asset_page, asset_step))
                print(resp_assets.text)
            else:
                assets = resp_assets.json()["data"]
                asset_binds = []
                for asset in assets:
                    if (asset["relatedParks"]
                            and asset["relatedParks"][0]["parkCode"]
                            # None of these park codes are parks but either places, subjects or locations
                            not in ("mehi", "inau", "blac", "guge", "chbl", "cbgn", "erie",
                                    "dabe", "fati", "cala", "esse", "armo", "mush", "auca",
                                    "crha", "soca", "tecw", "rist")):
                        asset_binds.append({
                            "image_id": asset["id"],
                            # Extract the gallery id from the permalinkUrl
                            "gallery_id": asset["permalinkUrl"][asset["permalinkUrl"].index("gid=")+4:],
                            "title": asset["title"],
                            "description": asset["description"],
                            "alt_text": asset["altText"],
                            "permalink_url": asset["permalinkUrl"],
                            "credit": asset["credit"],
                            "copyright": asset["copyright"],
                            "copyright_constraint": asset["constraintsInfo"]["constraint"],
                            "copyright_granted_rights": asset["constraintsInfo"]["grantingRights"],
                            "tags": convert_tags(asset["tags"]),
                            "url": asset["fileInfo"]["url"],
                            "file_type": asset["fileInfo"]["fileType"],
                            "width_pixels": asset["fileInfo"]["widthPixels"],
                            "height_pixels": asset["fileInfo"]["heightPixels"],
                            "file_size_bytes": asset["fileInfo"]["fileSizeKb"],
                            "park_code":
                                sanitize_park_code(
                                asset["relatedParks"][0]["parkCode"])
                                if asset["relatedParks"]
                                else ""
                        })
                c = db.cursor()
                c.executemany(
                    """INSERT INTO images_stage (image_id, gallery_id, title, description, alt_text,
                                                 credit, copyright, copyright_constraint, permalink_url,
                                                 copyright_granted_rights, tags, url, file_type,
                                                 width_pixels, height_pixels, file_size_bytes, park_code)
                                      VALUES (:image_id, :gallery_id, :title, :description, :alt_text,
                                                 :credit, :copyright, :copyright_constraint, :permalink_url,
                                                 :copyright_granted_rights, :tags, :url, :file_type,
                                                 :width_pixels, :height_pixels, :file_size_bytes, :park_code)""",
                    asset_binds)
                c.close()
                db.commit()
                print("{} assets retrieved.".format(len(assets)))
        # Insert park_id for each image based on park_code
        c = db.cursor()
        c.execute("UPDATE images_stage s SET park_id = (SELECT park_id FROM parks p WHERE p.park_code = s.park_code")
        c.close()
        db.commit()


def get_park_activities():
    resp = requests.get(BASE_URL + "/activities/parks?limit=1000&api_key=" + API_KEY)
    if not resp.ok:
        print(resp.text)
    else:
        data = resp.json()["data"]
        activities = []
        park_activities = []
        for d in data:
            activities.append({
                "activity_id": d["id"],
                "name": d["name"]
            })
            for p in d["parks"]:
                park_activity = {
                    "park_code": sanitize_park_code(p["parkCode"]),
                    "activity_id": d["id"]
                }
                # Because some parkCodes have been consolidated, we need to check for duplicates for these
                if not any(d["park_code"] == park_activity["park_code"]
                           and d["activity_id"] == park_activity["activity_id"]
                           for d in park_activities):
                    park_activities.append(park_activity)

        c = db.cursor()
        c.executemany("""INSERT INTO activities (activity_id, name) VALUES(:activity_id, :name)""", activities)
        c.executemany("""INSERT INTO parks_activities (park_id, activity_id) 
        SELECT park_id, :activity_id
          FROM parks
            WHERE park_code = :park_code""", park_activities)
        c.close()
        db.commit()


def get_park_data():
    resp = requests.get(BASE_URL + "/parks?limit=1000&api_key=" + API_KEY)
    if not resp.ok:
        print(resp.text)
    else:
        data = resp.json()["data"]
        for d in data:
            # mehi is a place, not a park
            if d["parkCode"] == "mehi":
                continue
            binds = {
                "park_id": d["id"],
                "park_code": sanitize_park_code(d["parkCode"]),
                "name": d["name"],
                "url": d["url"],
                "full_name": d["fullName"],
                "description": d["description"],
                "designation": d["designation"],
                "latitude": d["latitude"],
                "longitude": d["longitude"],
                "state": d["states"],
                "directions_info": d["directionsInfo"],
                "directions_url": d["directionsUrl"],
                "weather_info": d["weatherInfo"]
            }
            contacts = d["contacts"]
            contact_list = []

            if "phoneNumbers" in contacts:
                for phone_number in contacts["phoneNumbers"]:
                    number = sanitize_phone_number(phone_number["phoneNumber"])
                    type = phone_number["type"]
                    contact_list.append((number, type))

            if "emailAddresses" in contacts:
                for email in contacts["emailAddresses"]:
                    contact_list.append((email["emailAddress"], "email"))

            c = db.cursor()
            c.execute("""
            INSERT INTO parks (park_id, park_code, name, full_name, url, description,
                               designation, latitude, longitude, state, directions_info,
                               directions_url, weather_info, country_id)
              VALUES (:park_id, :park_code, :name, :full_name, :url, :description,
                      :designation, :latitude, :longitude, :state, :directions_info,
                      :directions_url, :weather_info, 'USA')""",
                      binds)

            if contact_list:
                binds1 = []
                for contact in contact_list:
                    binds1.append({
                        "contact": contact[0],
                        "type": get_contact_type(contact[1]),
                        "park_id": binds["park_id"]
                    })
                c.executemany("""
                INSERT INTO contacts (contact, contact_type_id, park_id)
                VALUES (:contact, :type, :park_id)
                """, binds1)
            c.close()
    db.commit()


if __name__ == "__main__":
    if API_KEY is None:
        print("No API_KEY provided")
        exit(1)

    get_park_data()
    get_park_activities()
    # Images will be stored in a `images_staging` table.
    # Further cleansing of the data needs to happen as some images are duplicated in the data set.
    get_park_pictures()
