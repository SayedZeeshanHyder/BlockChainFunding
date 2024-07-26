import React from 'react';

function Modal({ show, onClose, fundTitle, fundImage }) {
  if (!show) {
    return null;
  }

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center">
      <div className="bg-white p-8 rounded-lg w-[400px]">
        <div className="text-right">
          <button onClick={onClose}><img src="/src/images/cross.svg" className="w-[15px]" alt="" /></button>
        </div>
        <div className="text-center font-bold text-xl mb-4">{fundTitle}</div>
        <div className="flex justify-center mb-4">
          <img src={fundImage} alt={fundTitle} className="h-[150px] w-[300px] object-cover" />
        </div>
        <div className="mb-4">
          <input type="text" className="w-full p-2 border border-gray-300 rounded" placeholder="Enter amount in ETH" />
        </div>
        <div className="flex justify-center">
          <button className="bg-green-600 text-black font-bold px-4 py-2 rounded-full hover:shadow-lg">Submit</button>
        </div>
      </div>
    </div>
  );
}

export default Modal;
