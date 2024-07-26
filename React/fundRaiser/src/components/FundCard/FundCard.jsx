import React from "react";
import {Link} from 'react-router-dom';

function FundCard(props) {
    return (
        <>
            <Link to="/fund">
            <div className="duration-100 hover:shadow-2xl justify-start flex flex-col md:flex-row shadow overflow-hidden cursor-pointer rounded-3xl m-5 md:m-10 w-96 md:w-auto">

                    <div className="w-50 md:w-1/2 md:h-full h-40 m-5 rounded-2xl">
                    <img src="src/images/fundcard.jpg" alt="" className="h-full rounded-2xl" />
                    <div className="relative bottom-8 left-4 bg-gray-600 w-32 text-center rounded-full opacity-70 text-white">
                        3.2K donations
                    </div>
                    </div>
              
                <div className="flex-col mt-3 w-full md:w-1/2 justify-center p-5">
                    <div className="text-3xl font-semibold text-center">
                        {props.title}
                    </div>
                    <div className="w-auto mt-2">
                        <p className="text-sm md:text-base opacity-65">
                            Lorem, ipsum dolor sit amet consectetur adipisicing elit. A neque blanditiis porro provident, dolore, ex accusantium consectetur nemo maiores eos aliquid delectus mollitia optio architecto minima, vitae cum! Quo adipisci sint neque recusandae repellat.
                        </p>
                    </div>
                    <div className="w-full h-2 mt-3 bg-[rgba(230,246,239,1)] rounded">
                        <div className="w-[80%] h-2 bg-green-500 opacity-100 rounded">
                        </div>
                    </div>
                    <div className="text-end mt-3 text-sm md:text-base">
                        {props.eths} ETH raised
                    </div>
                </div>
            </div>
            </Link>
        </>
    );
}

export default FundCard;
