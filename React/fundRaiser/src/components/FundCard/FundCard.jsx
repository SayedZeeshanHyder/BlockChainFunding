import React from "react";

function FundCard({ title, aim, collected, description, imageUrl }) {
  return (
    <>
      <div className="duration-100 hover:shadow-2xl justify-start flex flex-col md:flex-row shadow overflow-hidden cursor-pointer rounded-3xl m-5 md:m-10 w-96 md:w-auto">
        <div className="w-50 md:w-1/2 md:h-full h-40 m-5 rounded-2xl">
          {/* Display the image from Firebase */}
          <img src={imageUrl} alt={title} className="h-full rounded-2xl" />
          <div className="relative bottom-8 left-4 bg-gray-600 w-32 text-center rounded-full opacity-70 text-white">
            {collected} ETH collected
          </div>
        </div>

        <div className="flex-col mt-3 w-full md:w-1/2 justify-center p-5">
          <div className="text-3xl font-semibold text-center">{title}</div>
          <div className="w-auto mt-2">
            <p className="text-sm md:text-base opacity-65">{description}</p>
          </div>
          <div className="w-full h-2 mt-3 bg-[rgba(230,246,239,1)] rounded">
            <div
              className="bg-green-500 h-2 rounded"
              style={{ width: `${(collected / aim) * 100}%` }} // Progress bar based on collected/aim
            />
          </div>
          <div className="text-end mt-3 text-sm md:text-base">
            {collected} ETH raised out of {aim} ETH
          </div>
        </div>
      </div>
    </>
  );
}

export default FundCard;
