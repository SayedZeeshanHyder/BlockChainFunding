import React, { useState } from 'react';
import NavBar from "../NavBar/NavBar";
import TransactionTable from "../TransactionTable/TransactionTable";
import Modal from './Modal';
function FundsPage() {
  const [showModal, setShowModal] = useState(false);

  const data = [
    { date: '2024-06-29', wallet: '0xABC123', fund: 'Fund A', amount: '1' },
    { date: '2024-06-30', wallet: '0xDEF456', fund: 'Fund B', amount: '1' },
    { date: '2024-06-30', wallet: '0xDEF456', fund: 'Fund C', amount: '4.5' },
    { date: '2024-06-30', wallet: '0xDEF456', fund: 'Fund D', amount: '1' },
    { date: '2024-06-30', wallet: '0xDEF456', fund: 'Fund E', amount: '0.3' },
    { date: '2024-06-30', wallet: '0xDEF456', fund: 'Fund E', amount: '0.3' },
  ];

  return (
    <>
      <div className="w-72 mt-2 ml-2">
        <img src="/src/images/Glorious Purpose.svg" alt="" />
      </div>
      <NavBar username="USERNAME" />

      <div className="absolute top-[10%] left-[25%] overflow-y-auto h-[90vh]">
        <div className="w-[60vw]">
          <div className="text-center font-bold text-2xl">
            CAMPAIGN TITLE
          </div>
          <div className="w-[60vw] flex justify-center mt-10 bg-green-200 rounded-lg">
            <div className="rounded-lg">
              <img src="/src/images/fundcard.jpg" alt="" className="h-[300px] bg-cover" />
            </div>
          </div>
          <div className="w-[60vw] flex justify-center mt-10 h-auto">
            <button
              className="w-[200px] p-2 m-5 bg-green-600 rounded-full cursor-pointer font-bold hover:shadow-lg"
              onClick={() => setShowModal(true)}
            >
              Make a Contribution
            </button>
          </div>

          <div className="w-[60vw] flex justify-between mt-10">
            <div className="bg-green-200 flex-col w-[40%] p-5 rounded-lg shadow-lg">
              <div className="font-bold mb-5 text-center">
                DESCRIPTION
              </div>
              <div>
                Lorem ipsum dolor sit, amet consectetur adipisicing elit. Consectetur sunt at, quasi nam mollitia, id rerum, sit ratione voluptatum veniam similique corporis minus. Error numquam repellat nulla non accusamus atque ea quod ut impedit?
              </div>
              <div className="text-green-600">
                <button>See full blog</button>
              </div>
            </div>
            <div className="bg-green-200 flex-col w-[40%] p-5 rounded-lg shadow-lg">
              <div className="font-bold">
                4ETH raised out of target 5ETH
              </div>
              <div className="w-[100%] bg-green-300 h-2 mt-2 rounded-full">
                <div className="w-[80%] h-2 bg-green-500"></div>
              </div>

              <div className="font-bold mt-4">
                Number of donations made :
              </div>
              <div>1K</div>
              <div className="font-bold mt-2">Target:</div>
              <div>5ETH</div>
              <div className="font-bold mt-2">Funds Raised:</div>
              <div>4ETH</div>
            </div>
          </div>

          <div className="w-[60vw] flex justify-center mt-10 mb-10">
            <TransactionTable data={data} />
          </div>
        </div>
      </div>

      <Modal
        show={showModal}
        onClose={() => setShowModal(false)}
        fundTitle="Fund Title"
        fundImage="/src/images/fundcard.jpg"
      />
    </>
  );
}

export default FundsPage;
