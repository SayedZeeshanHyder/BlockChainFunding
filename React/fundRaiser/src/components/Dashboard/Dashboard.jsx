import React, { useEffect, useState } from "react";
import HeaderD from "./HeaderD";
import NavBar from "../NavBar/NavBar";
import FundCard from "../FundCard/FundCard";
import { db } from "../../firebaseConfig.js"; // Import Firestore instance
import { collection, getDocs } from "firebase/firestore"; // Import Firestore functions

function Dashboard() {
  const [campaigns, setCampaigns] = useState([]);

  useEffect(() => {
    const fetchCampaigns = async () => {
      try {
        const querySnapshot = await getDocs(collection(db, "Campaigns"));
        const campaignData = [];

        querySnapshot.forEach((doc) => {
          const data = doc.data();
          if (data.Campaigns) {
            // Flatten the Campaigns array
            campaignData.push(...data.Campaigns);
          }
        });

        setCampaigns(campaignData);
      } catch (error) {
        console.error("Error fetching campaign data: ", error);
      }
    };

    fetchCampaigns();
  }, []);

  useEffect(() => {
    console.log(campaigns);
  }, [campaigns]);

  return (
    <>
      <HeaderD />
      <NavBar username="USERNAME" />
      <div className="fixed top-5 left-[30%] md:left-[17%]">
        <div className="flex w-full justify-center mt-10">
          <div className="flex-col overflow-y-auto h-[85vh] w-[100%] scroll-m-0">
            {campaigns.length > 0 ? (
              campaigns.map((campaign) => (
                <FundCard
                  key={campaign.campaignId} // Use campaignId as the key
                  title={campaign.title}
                  aim={campaign.aim}
                  collected={campaign.collected}
                  description={campaign.description}
                  imageUrl={campaign.imgUrl} // Updated to imgUrl
                />
              ))
            ) : (
              <p>Loading campaigns...</p>
            )}
          </div>
        </div>
      </div>
    </>
  );
}

export default Dashboard;
