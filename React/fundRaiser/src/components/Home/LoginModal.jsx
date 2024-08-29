import React, { useState, useEffect } from "react";
import Web3 from "web3";
import { useNavigate, Link } from "react-router-dom";

function LoginModal({ show, onClose }) {
  const [account, setAccount] = useState(null);
  const [web3, setWeb3] = useState(null);
  const [selectedOption, setSelectedOption] = useState("");
  const [showMoreOptions, setShowMoreOptions] = useState(false);
  const navigate = useNavigate();

  useEffect(() => {
    if (window.ethereum) {
      window.ethereum.on("accountsChanged", handleAccountsChanged);

      const fetchAccounts = async () => {
        const web3Instance = new Web3(window.ethereum);
        setWeb3(web3Instance);
        const accounts = await web3Instance.eth.getAccounts();
        if (accounts.length > 0) {
          setAccount(accounts[0]);
        }
      };

      fetchAccounts();

      return () => {
        if (window.ethereum) {
          window.ethereum.removeListener("accountsChanged", handleAccountsChanged);
        }
      };
    }
  }, []);

  const handleAccountsChanged = (accounts) => {
    if (accounts.length > 0) {
      setAccount(accounts[0]);
    } else {
      setAccount(null);
    }
  };

  const handleMetamaskLogin = async () => {
    if (window.ethereum) {
      try {
        const web3Instance = new Web3(window.ethereum);
        await window.ethereum.request({ method: "eth_requestAccounts" });

        // Send the account to the backend for authentication
        const response = await fetch("http://localhost:5000/auth/login", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({ account: `${(await web3Instance.eth.getAccounts())[0]}` }),
        });

        if (!response.ok) {
          throw new Error('Failed to log in');
        }

        const { token } = await response.json();

        // Store the JWT in localStorage
        localStorage.setItem('jwtToken', token);

        // Redirect to the initial path
        navigate("/dashboard");
        onClose();
      } catch (error) {
        console.error("Error logging in with Metamask:", error);
      }
    } else {
      alert("Please install Metamask.");
    }
  };

  if (!show) {
    return null;
  }

  const handleOptionClick = (option) => {
    setSelectedOption(option);
  };

  const getBorderClass = (option) => {
    return selectedOption === option ? 'border-green-500 border-2 shadow-md' : "";
  };

  const moreWalletOptions = [
    'Phantom',
    'BitKeep',
    'Kaikas',
    'Core',
    'Fortmatic',
    'Bitski',
  ];

  return (
      <div className="fixed inset-0 bg-gray-600 bg-opacity-75 flex items-center justify-center z-50">
        <div className="bg-white p-6 rounded-lg shadow-lg relative w-full max-w-md">
          <button
              className="absolute top-2 right-2 text-gray-600 hover:text-gray-900 focus:outline-none"
              onClick={onClose}
          >
            <img src="/src/images/cross.svg" className="w-[20px] h-[20px]" alt="Close" />
          </button>
          <h2 className="text-2xl font-semibold text-center mb-4">Login</h2>
          <div
              className={`flex justify-start items-center rounded-lg mb-2 h-[40px] bg-green-200 cursor-pointer ${getBorderClass('metamask')}`}
              onClick={handleMetamaskLogin}
          >
            <div className='mr-3 ml-3'>
              <img src="/src/images/metamask-icon.svg" alt="Metamask" className='w-[25px] h-[25px]' />
            </div>
            <div className='font-bold'>
              Metamask
            </div>
          </div>
          <div
              className={`flex justify-start items-center rounded-lg h-[40px] mb-2 bg-green-200 cursor-pointer ${getBorderClass('walletconnect')}`}
              onClick={() => handleOptionClick('walletconnect')}
          >
            <div className='mr-3 ml-3'>
              <img src="/src/images/walletconnect.png" alt="Wallet Connect" className='w-[25px] h-[25px]' />
            </div>
            <div className='font-bold'>
              Wallet Connect
            </div>
          </div>
          <div
              className={`flex justify-start items-center bg-green-200 rounded-lg h-[40px] cursor-pointer ${getBorderClass('coinbase')}`}
              onClick={() => handleOptionClick('coinbase')}
          >
            <div className='mr-3 ml-3'>
              <img src="/src/images/coinbase.png" alt="Coinbase" className='w-[25px] h-[25px]' />
            </div>
            <div className='font-bold'>
              Coinbase
            </div>
          </div>

          <div
              className='mt-12 w-[100%] flex justify-center cursor-pointer hover:text-green-800'
              onClick={() => setShowMoreOptions(!showMoreOptions)}
          >
            <div>
              {showMoreOptions ? 'Show less options' : 'More wallet options'}
            </div>
          </div>

          {showMoreOptions && (
              <div className="mt-4 space-y-2 h-[50vh] overflow-y-auto">
                {moreWalletOptions.map((option, index) => (
                    <div
                        key={index}
                        className={`flex justify-start items-center h-[40px] rounded-lg bg-green-200 cursor-pointer ${getBorderClass(option.toLowerCase().replace(/\s+/g, ''))}`}
                        onClick={() => handleOptionClick(option.toLowerCase().replace(/\s+/g, ''))}
                    >
                      <div className='mr-3 ml-3'>
                        <img src={`/src/images/${option.toLowerCase().replace(/\s+/g, '')}.png`} alt={option} className='w-[25px] h-[25px]' />
                      </div>
                      <div className='font-bold'>
                        {option}
                      </div>
                    </div>
                ))}
              </div>
          )}
        </div>
      </div>
  );
}

export default LoginModal;
