import React, { useState, useEffect, useRef } from "react";
import { useNavigate, Link } from "react-router-dom";
import "./Home.css";
import logo from "/src/images/Glorious Purpose.svg";
import charityImg from "/src/images/charity-img.png";
import disasterImg from "/src/images/diasater-img.png";
import medicalImg from "/src/images/medical-img.png";
import crowdImg from "/src/images/crowdf-img.png";
import ellipse from "/src/images/Ellipse 2.svg";
import useResponsive from "/src/useResponsive";
import LoginModal from "./LoginModal";

function Home() {
    const { width } = useResponsive();
    const [isModalOpen, setModalOpen] = useState(false);
    const aboutRef = useRef(null);
    const navigate = useNavigate();

    useEffect(() => {
        const verifyToken = async () => {
            try {
                const token = localStorage.getItem('jwtToken');

                if (token) {
                    const response = await fetch("http://localhost:5000/auth/verify", {
                        method: "POST",
                        headers: {
                            "Content-Type": "application/json",
                        },
                        body: JSON.stringify({ token }),
                    });

                    if (!response.ok) {
                        throw new Error('Failed to verify token');
                    }

                    const { valid } = await response.json();

                    if (valid) {
                        navigate("/dashboard");
                    }
                }
            } catch (error) {
                console.error("Error verifying token:", error);
            }
        };

        verifyToken();
    }, [navigate]);

    const openModal = () => setModalOpen(true);

    const closeModal = () => setModalOpen(false);

    const scrollToAbout = () => {
        aboutRef.current.scrollIntoView({ behavior: "smooth" });
    };

  return (
    <div className="App">
      <header className={`top ${isModalOpen ? 'content-blur' : ''}`}>
        <nav className="nav">
          <img src={logo} alt="Logo" className="logo" />
          <button className="btn" id="abt" onClick={scrollToAbout}>About us</button> {/* Update onClick handler */}
          <button className="btn" onClick={openModal}>Login</button>
        </nav>
      </header>

      <div className={`space ${isModalOpen ? 'content-blur' : ''}`}></div>

      <div className={`ani-cont ${isModalOpen ? 'content-blur' : ''}`}>
        <DisplayBox title="Charity" imgSrc={charityImg} width={width} />
        <DisplayBox title="Disaster Relief" imgSrc={disasterImg} width={width} />
        <DisplayBox title="Medical funds" imgSrc={medicalImg} width={width} />
        <DisplayBox title="Crowd Funding" imgSrc={crowdImg} width={width} />
      </div>

      <div className={`quote ${isModalOpen ? 'content-blur' : ''}`}>
        “LETS SUPPORT THOSE IN NEED”
      </div>

      <div className={`ellipse ${isModalOpen ? 'content-blur' : ''}`}>
        <img src={ellipse} alt="Ellipse" />
        <AboutSection ref={aboutRef} /> {/* Pass the ref to the AboutSection component */}
      </div>

      <LoginModal show={isModalOpen} onClose={closeModal} />
    </div>
  );
}

function DisplayBox({ title, imgSrc, width }) {
  return (
    <div className="dis-box">
      <div className="g-text">{title}</div>
      <div className="img-box">
        <img src={imgSrc} alt={title} />
      </div>
    </div>
  );
}

const AboutSection = React.forwardRef((props, ref) => { // Update AboutSection to accept a ref
  return (
    <div className="about-section" ref={ref}>
      <h2>About Us</h2>
      <p id="about">
        Welcome to our fundraiser website!<br />
        We are dedicated to making a positive impact in the community by creating a platform to raise funds for various causes and initiatives. Our team consists of passionate individuals who believe in the power of collective action to bring about change.
      </p>
      <div className='flex w-[100vw] justify-evenly'>
        <ProfileSection name="Yash Shellar"/>
        <ProfileSection name="Ashmit Shelke" gmail="ashmit.shelke3135@gmail.com"/>
        <ProfileSection name="Zeeshan Hyder"/>
      </div>
    </div>
  );
});

function ProfileSection({name, linked_in, twitter, gmail, github}) {
  return (
    <div className='flex'>
      <div className='flex-col'>
        <div className='font-bold text-lg'>
          {name}
        </div>
        <div className='flex items-center'>
          <img src="/src/images/linked_in.svg" className='mr-5 w-[20px] h-[20px]' alt="" />
          <a href={linked_in}>Linked in</a>
        </div>
        <div className='flex items-center '>
          <img src="/src/images/twitter.svg" className='mr-5 w-[20px] h-[20px]' alt="" />
          <a href={twitter}>Twitter</a>
        </div>
        <div className='flex items-center'>
          <img src="/src/images/gmail.svg" className='mr-5 w-[20px] h-[20px]' alt="" />
          <a href={gmail}>Gmail</a>
        </div>
        <div className='flex items-center'>
          <img src="/src/images/git_icon.svg" className='mr-5 w-[20px] h-[20px]' alt="" />
          <a href={github}>Github</a>
        </div>
      </div>
    </div>
  );
}

export default Home;
